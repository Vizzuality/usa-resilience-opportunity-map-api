# Class to import the indicator data from a csv file
class ImportIndicatorData
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATOR DATA <<<'

      # TODO: This code is terrible. This should be fixed.
      filename = Rails.root.join('db/files/indicator_data/indicator_data.csv')
      i = 0
      CSV.foreach(filename, col_sep: ',', row_sep: :auto, headers: true, encoding: 'UTF-8') do |row|
        i += 1
        puts i if i%100
        data_row = row.to_h
        geometry = Geometry.find_by gid: data_row['geoid']

        data_row.to_a[4..-1].each_slice(4) do |data|
          indicator = Indicator.find_by slug: data.first.first.split('_').first
          indicator_datum = IndicatorDatum.find_or_create_by geometry_id: geometry.id, indicator_id: indicator.id
          indicator_datum.absolute_value = data.first.last
          indicator_datum.normalized_value = data.second.last
          indicator_datum.hazard_value = data.third.last
          indicator_datum.range = data.fourth.last
          indicator_datum.save
        end
      end

      puts '>>> FINISHED IMPORTING INDICATOR DATA <<<'
    end
  end
end
