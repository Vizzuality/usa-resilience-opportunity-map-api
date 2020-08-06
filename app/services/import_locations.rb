# Class to import the locations from a json file
class ImportLocations
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING LOCATIONS <<<'

      puts '>>> IMPORTING STATES <<<'

      file = Rails.root.join('db/files/geometries/states.json').open
      data = JSON.load file

      data['features'].each do |feature|
        properties = feature['properties']
        geometry = Geometry.find_or_create_by gid: properties['geoid']
        geometry.name = properties['name']
        geometry.location_type = Geometry.location_types['state']
        geometry.state_fp = properties['statefp']
        geometry.bbox = properties['bbox']
        geometry.geojson = feature
        geometry.properties = properties
        geometry.save
      end

      puts '>>> FINISHED IMPORTING STATES <<<'


      puts '>>> IMPORTING COUNTIES <<<'

      file = Rails.root.join('db/files/geometries/counties.json').open
      data = JSON.load file

      data['features'].each do |feature|
        properties = feature['properties']
        geometry = Geometry.find_or_create_by gid: properties['geoid']
        geometry.parent_id = Geometry.state.find_by(state_fp: properties['statefp'])&.id
        geometry.name = properties['name']
        geometry.location_type = Geometry.location_types['county']
        geometry.state_fp = properties['statefp']
        geometry.county_fp = properties['countyfp']
        geometry.bbox = properties['bbox']
        geometry.geojson = feature
        geometry.properties = properties
        geometry.save
      end

      puts '>>> FINISHED IMPORTING COUNTIES <<<'

      puts '>>> GENERATING GEOMETRIES <<<'

      query =
          <<~SQL
        WITH g as (
        SELECT *, x.properties as prop, ST_GeomFromGeoJSON(x.geometry) as the_geom
        FROM geometries CROSS JOIN LATERAL
        jsonb_to_record(geojson) AS x("type" TEXT, geometry jsonb, properties jsonb )
        )
        update geometries
        set geom = g.the_geom , properties = g.prop
        from g
        where geometries.id = g.id;
      SQL
      ActiveRecord::Base.connection.execute query

      puts '>>> FINISHED GENERATING GEOMETRIES <<<'

      puts '>>> FINISHED IMPORTING LOCATIONS <<<'
    end
  end
end
