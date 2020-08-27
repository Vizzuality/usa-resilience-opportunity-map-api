# == Schema Information
#
# Table name: indicators
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  category_id :bigint
#  relevant    :boolean          default(FALSE)
#  labels      :string           default([]), is an Array
#
class Indicator < ApplicationRecord
  belongs_to :category
  has_many :indicator_data

  validates_inclusion_of :relevant, in: [true, false]

  def labels=(values)
    return super values.split(' ') if values.is_a? String

    super values
  end
end
