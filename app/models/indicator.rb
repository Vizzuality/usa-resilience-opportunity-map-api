# == Schema Information
#
# Table name: indicators
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string
#  category_id      :bigint
#  relevant         :boolean          default(FALSE)
#  labels           :string           default([]), is an Array
#  legend_states    :string           default([]), is an Array
#  legend_countries :string           default([]), is an Array
#  legend_title     :string
#  external_id      :integer
#  parent_id        :bigint
#  legend_tracts    :string           default([]), is an Array
#
class Indicator < ApplicationRecord
  belongs_to :category
  has_many :indicator_data
  has_many :sub_indicators, class_name: 'Indicator', foreign_key: :parent_id

  validates_inclusion_of :relevant, in: [true, false]

  def labels_raw=(values)
    self.labels = values.split(', ')
  end

  def labels_raw
    self.labels.join(', ')
  end

  def legend_states_raw=(values)
    self.legend_states =  values.split(', ')
  end

  def legend_states_raw
    self.legend_states.join(', ')
  end

  def legend_countries_raw=(values)
    self.legend_countries = values.split(', ')
  end

  def legend_countries_raw
    self.legend_countries.join(', ')
  end

  def legend_tracts_raw=(values)
    self.legend_tracts = values.split(', ')
  end

  def legend_tracts_raw
    legend_tracts.join(', ')
  end
end
