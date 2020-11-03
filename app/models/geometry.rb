# == Schema Information
#
# Table name: geometries
#
#  id            :bigint           not null, primary key
#  geom          :geometry         geometry, 0
#  name          :string           not null
#  description   :text
#  gid           :string           not null
#  location_type :integer          not null
#  parent_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state_fp      :integer
#  county_fp     :integer
#  geojson       :jsonb
#  properties    :jsonb
#  bbox          :jsonb
#  tract_ce      :integer
#
class Geometry < ApplicationRecord
  has_many :indicator_data
  has_many :children, class_name: 'Geometry', foreign_key: :parent_id
  enum location_type: {county: 1, state: 2, census: 3}

  validates_presence_of :name, :gid, :location_type

  scope :by_name, ->(string) { where('name ILIKE ?', "%#{string}%")}

  def self.vector_tiles(param_z, param_x, param_y, level, parent_id)
    level ||= '1'
    begin
      x, y, z = Integer(param_x), Integer(param_y), Integer(param_z)
      throw ArgumentError unless %w[1 2 3].include? level
      if level == '3'
        throw ArgumentError.new('Invalid parent id') unless Geometry.find(parent_id).location_type == 'county'
      end
    rescue ArgumentError, TypeError => e
      Rails.logger.warn "Vector Tiles wrong params: #{e.message}"
      return nil
    end

    filter =
      case level
      when '1'
        ' location_type = 2 '
      when '2'
        ' location_type IN (1,2) '
      when '3'
        " parent_id = #{parent_id} "
      end

    query =
      <<~SQL
    WITH mvt_data as ( select
    geometry_id as id,
    indicator_data_pivot.properties || jsonb_build_object('parent_id', parent_id, 'location_type', location_type, 'name', name, 'id', geometry_id) as properties,
    geom,
    bbox,
    st_transform(geom, 3857) as the_geom_webmercator
  from
    indicator_data_pivot
  inner join geometries g2 on
    g2.id = geometry_id
 WHERE #{filter} AND ST_AsMVTGeom(st_transform(geom, 3857), ST_TileEnvelope(#{z},#{x},#{y}),4096,0,true) IS NOT NULL
)
SELECT ST_ASMVT(tile.*, 'layer0', 4096, 'mvtgeometry', 'id') as tile
FROM (SELECT id, properties, ST_AsMVTGeom(the_geom_webmercator, ST_TileEnvelope(#{z},#{x},#{y}), 4096, 256, true) AS mvtgeometry
FROM mvt_data) AS tile;
    SQL

    tile = ActiveRecord::Base.connection.execute query
    ActiveRecord::Base.connection.unescape_bytea tile.getvalue(0, 0)
  end
end
