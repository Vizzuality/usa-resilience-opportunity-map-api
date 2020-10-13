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

  def self.vector_tiles(param_z, param_x, param_y)
    begin
      x, y, z = Integer(param_x), Integer(param_y), Integer(param_z)
    rescue ArgumentError, TypeError
      return nil
    end

    query =
      <<~SQL
        with indicator_join as (
          select
            geometry_id, hazard_value, id.absolute_value, id.normalized_value, range, i.slug, i.name as indicator_name, c.name as category_name
          from
            indicator_data id
          inner join indicators i on
            id.indicator_id = i.id
          inner join categories c on
            i.category_id = c.id),
        result as (
        select jsonb_object_agg(slug || '_hazard', hazard_value) || jsonb_object_agg(slug || '_abs', absolute_value) || jsonb_object_agg(slug || '_norm', normalized_value) || jsonb_object_agg(slug, indicator_name) || jsonb_object_agg(slug || '_cat', category_name) as properties,
          geometry_id
        from
          indicator_join
        group by
          geometry_id)

        SELECT ST_ASMVT(tile.*, 'layer0', 4096, 'mvtgeometry', 'id') as tile
        FROM (SELECT id, properties, ST_AsMVTGeom(the_geom_webmercator, ST_TileEnvelope(#{z},#{x},#{y}), 4096, 256, true) AS mvtgeometry
        FROM (
          select
            geometry_id as id,
            result.properties || jsonb_build_object('parent_id', parent_id, 'location_type', location_type, 'name', name, 'id', geometry_id) as properties,
            geom,
            bbox,
            st_transform(geom, 3857) as the_geom_webmercator
          from
            result
          inner join geometries g2 on
            g2.id = geometry_id
        ) as data
        WHERE ST_AsMVTGeom(the_geom_webmercator, ST_TileEnvelope(#{z},#{x},#{y}),4096,0,true) IS NOT NULL) AS tile;

    SQL

    tile = ActiveRecord::Base.connection.execute query
    ActiveRecord::Base.connection.unescape_bytea tile.getvalue(0, 0)
  end
end
