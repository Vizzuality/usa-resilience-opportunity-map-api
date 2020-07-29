# == Schema Information
#
# Table name: indicator_data
#
#  id           :bigint           not null, primary key
#  hazard_value :integer
#  geometry_id  :bigint           not null
#  indicator_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class IndicatorDatum < ApplicationRecord
  belongs_to :geometry
  belongs_to :indicator
end
