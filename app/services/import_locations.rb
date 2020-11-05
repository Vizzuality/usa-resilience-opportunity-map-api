# Class to import the locations from a json file
class ImportLocations
  DEFAULT_TYPES = %w[states counties censuses]

  def initialize(types = DEFAULT_TYPES)
    @types = types & DEFAULT_TYPES
    @bulk_insert = BulkInsertService.new(Geometry, 1000)
  end

  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING LOCATIONS <<<'
      import_states if @types.include? 'states'
      import_counties if @types.include? 'counties'
      import_censuses if @types.include? 'censuses'
      generate_geometries
      puts '>>> FINISHED IMPORTING LOCATIONS <<<'
    end
  end

  private

  def import_states
    puts '>>> IMPORTING STATES <<<'

    data('states')['features'].each do |feature|
      properties = feature['properties']

      geometry = {
        gid: properties['geoid'],
        name: properties['name'],
        location_type: Geometry.location_types['state'],
        state_fp: properties['statefp'],
        bbox: properties['bbox'],
        geojson: feature,
        properties: properties,
      }
      @bulk_insert.call geometry
    end
    @bulk_insert.terminate
    puts '>>> FINISHED IMPORTING STATES <<<'
  end

  def import_counties
    puts '>>> IMPORTING COUNTIES <<<'

    data('counties')['features'].each do |feature|
      properties = feature['properties']

      geometry = {
          gid: properties['geoid'],
          parent_id: Geometry.state.find_by(state_fp: properties['statefp'])&.id,
          name: properties['name'],
          location_type: Geometry.location_types['county'],
          state_fp: properties['statefp'],
          county_fp: properties['countyfp'],
          bbox: properties['bbox'],
          geojson: feature,
          properties: properties
      }
      @bulk_insert.call geometry
    end

    @bulk_insert.terminate
    puts '>>> FINISHED IMPORTING COUNTIES <<<'
  end

  def import_censuses
    puts '>>> IMPORTING CENSUSES <<<'


    data('censuses')['features'].each do |feature|
      properties = feature['properties']

      geometry = {
        gid: properties['geoid'],
        parent_id: Geometry.county.find_by(county_fp: properties['countyfp'], state_fp: properties['statefp'])&.id,
        name: properties['name'],
        location_type: Geometry.location_types['census'],
        state_fp: properties['statefp'],
        county_fp: properties['countyfp'],
        tract_ce: properties['tractce'],
        bbox: properties['bbox'],
        geojson: feature,
        properties: properties
      }
      @bulk_insert.call(geometry)
    end

    @bulk_insert.terminate

    puts '>>> FINISHED IMPORTING COUNTIES <<<'
  end

  def generate_geometries
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
  end

  def data(filename)
    file = Rails.root.join("db/files/geometries/#{filename}.json").open
    JSON.load(file)
  end
end
