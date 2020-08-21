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
#
class Indicator < ApplicationRecord
  belongs_to :category
  has_many :indicator_data

  validates_presence_of :relevant
end
