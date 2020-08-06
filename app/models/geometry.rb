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
#
class Geometry < ApplicationRecord
  has_many :indicator_data
  has_many :children, class_name: 'Geometry', foreign_key: :parent_id
  enum location_type: {county: 1, state: 2}

  validates_presence_of :name, :gid, :location_type

  scope :by_name, ->(string) { where('name ILIKE ?', "%#{string}%")}

  def self.vector_tiles(param_z, param_x, param_y)
    begin
      x, y, z = Integer(param_x), Integer(param_y), Integer(param_z)
    rescue ArgumentError, TypeError
      return nil
    end

    query =
        <<~SQL
            SELECT ST_ASMVT(tile.*, 'layer0', 4096, 'mvtgeometry', 'id') as tile
             FROM (SELECT id, properties, ST_AsMVTGeom(the_geom_webmercator, ST_TileEnvelope(#{z},#{x},#{y}), 4096, 256, true) AS mvtgeometry
                                      FROM (select *, st_transform(geom, 3857) as the_geom_webmercator from geometries) as data
                                    WHERE ST_AsMVTGeom(the_geom_webmercator, ST_TileEnvelope(#{z},#{x},#{y}),4096,0,true) IS NOT NULL) AS tile;
    SQL

    tile = ActiveRecord::Base.connection.execute query
    ActiveRecord::Base.connection.unescape_bytea tile.getvalue(0, 0)
  end
end
