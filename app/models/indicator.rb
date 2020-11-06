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

  def labels=(values)
    return super values.split(', ') if values.is_a? String

    super values
  end

  def legend_states=(values)
    return super values.split(', ') if values.is_a? String

    super values
  end

  def legend_countries=(values)
    return super values.split(', ') if values.is_a? String

    super values
  end

  def legend_tracts=(values)
    return super values.split(', ') if values.is_a? String

    super values
  end
end
