# Class to import the indicator data from a csv file
class ImportIndicatorData
  def initialize
    @indicator_data = []
  end

  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATOR DATA <<<'
      time = Time.now
      puts "Starting at #{time.to_s}"
      filename = Rails.root.join('db/files/indicator_data/indicator_data.csv')
      time = Time.now
      indicators = Indicator.all.order(:slug).pluck(:slug, :id).to_h
      geometries = Geometry.all.order(:gid).pluck(:gid, :id).to_h
      bulk_insert = BulkInsertService.new(IndicatorDatum, 50000)

      # TODO move this to the service
      CSV.foreach(filename, col_sep: ',', row_sep: :auto, headers: true, encoding: 'UTF-8').with_index do |row, i|
        data_row = row.to_h
        geometry = geometries[data_row['geoid']]

        data_row.to_a[4..-1].each_slice(4) do |data|
          begin
            indicator = indicators[data.first.first.split('_').first]
            indicator_datum = { geometry_id: geometry, indicator_id: indicator }
            indicator_datum[:absolute_value] = data.first.last
            indicator_datum[:normalized_value] = data.second.last
            indicator_datum[:hazard_value] = data.third.last
            indicator_datum[:range] = data.fourth.last
            indicator_datum[:created_at] = time
            indicator_datum[:updated_at] = time

            bulk_insert.call indicator_datum
          rescue Exception
            puts ">>>>>>>>>>>> Error importing data: #{e.message}"
            puts data
            puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
          end
        end

      end
      bulk_insert.terminate
      
      puts '>>> FINISHED IMPORTING INDICATOR DATA <<<'
      puts "Took: #{Time.now - time} seconds"
    end
  end
end
