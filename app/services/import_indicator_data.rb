# Class to import the indicator data from a csv file
class ImportIndicatorData
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATOR DATA <<<'

      mapping = indicator_mapping
      filename = Rails.root.join('db/files/indicator_data/indicator_data.csv')
      CSV.foreach(filename, col_sep: ',', row_sep: :auto, headers: true, encoding: 'UTF-8') do |row|
        data_row = row.to_h
        geometry = Geometry.find_by gid: data_row['geoid']

        data_row.to_a[4..-1].each do |data|
          indicator_datum = IndicatorDatum.find_or_create_by geometry_id: geometry.id, indicator_id: mapping[data.first]
          indicator_datum.hazard_value = data.last
          indicator_datum.save
        end
      end

      puts '>>> FINISHED IMPORTING INDICATOR DATA <<<'
    end
  end

  # TODO:
  # This shouldn't be like this.
  # This way the indicators are hardcoded.
  # The names of the columns should be the same as the names of the indicators
  def indicator_mapping
    mapping = {}

    mapping['pop'] = Indicator.find_by(name: 'population').id
    mapping['pop_score'] = Indicator.find_by(name: '').id
    mapping['pop_cat'] = Indicator.find_by(name: '').id
    mapping['pop_range'] = Indicator.find_by(name: '').id
    mapping['rfr'] = Indicator.find_by(name: '').id
    mapping['rfr_score'] = Indicator.find_by(name: '').id
    mapping['rfr_cat'] = Indicator.find_by(name: '').id
    mapping['rfr_range'] = Indicator.find_by(name: '').id
    mapping['bws'] = Indicator.find_by(name: '').id
    mapping['bws_score'] = Indicator.find_by(name: '').id
    mapping['bws_cat'] = Indicator.find_by(name: '').id
    mapping['bws_range'] = Indicator.find_by(name: '').id

    mapping
  end
end