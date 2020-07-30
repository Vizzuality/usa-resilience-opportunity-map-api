# == Schema Information
#
# Table name: indicator_data
#
#  id               :bigint           not null, primary key
#  hazard_value     :integer
#  geometry_id      :bigint           not null
#  indicator_id     :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  absolute_value   :float
#  normalized_value :float
#  range            :string
#
require 'test_helper'

class IndicatorDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
