# Class to import the indicator data from a csv file
class ImportIndicatorData
  def initialize
    @indicator_data = []
  end

  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATOR DATA <<<'

      filename = Rails.root.join('db/files/indicator_data/indicator_data.csv')
      indicators = Indicator.all
      time = Time.now

      CSV.foreach(filename, col_sep: ',', row_sep: :auto, headers: true, encoding: 'UTF-8').with_index do |row, i|
        data_row = row.to_h
        geometry = Geometry.find_by gid: data_row['geoid']

        data_row.to_a[4..-1].each_slice(4) do |data|
          indicator = indicators.find_by slug: data.first.first.split('_').first
          indicator_datum = { geometry_id: geometry.id, indicator_id: indicator.id }
          indicator_datum[:absolute_value] = data.first.last
          indicator_datum[:normalized_value] = data.second.last
          indicator_datum[:hazard_value] = data.third.last
          indicator_datum[:range] = data.fourth.last
          indicator_datum[:created_at] = time
          indicator_datum[:updated_at] = time
          @indicator_data << indicator_datum
        end

        if i % 1000000
          puts "Inserting #{ActiveSupport::Inflector::ordinalize(i)} million rows"
          database_insert
        end
      end
      database_insert

      puts '>>> FINISHED IMPORTING INDICATOR DATA <<<'
    end
  end

  private

  def database_insert
    IndicatorDatum.insert_all(@indicator_data) if @indicator_data.any?
    @indicator_data = []
  end
end
