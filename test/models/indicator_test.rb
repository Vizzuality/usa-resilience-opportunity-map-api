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
require 'test_helper'

class IndicatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
