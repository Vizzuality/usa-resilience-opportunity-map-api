# Class to import the indicators from a json file
class ImportIndicators
  def call
    ActiveRecord::Base.transaction do
      puts '>>> IMPORTING INDICATORS <<<'

      filename = Rails.root.join('db/files/indicators/indicators.csv')
      CSV.foreach(filename, col_sep: ',', row_sep: :auto, headers: true, encoding: 'UTF-8') do |row|
        data_row = row.to_h
        category = Category.find_or_create_by! name: data_row['Category']
        group = data_row['Group']

        parent_id = if group.split('.').last != '0'
                      Indicator.find_by(external_id: "#{group.split('.').first}.0").id rescue nil
                    end

        Indicator.find_or_create_by! name: data_row['Name'], slug: data_row['Slug'], external_id: group,
                                     parent_id: parent_id, category: category
      end
      puts '>>> FINISHED IMPORTING INDICATORS <<<'
    end
  end
end
