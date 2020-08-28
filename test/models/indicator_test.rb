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
#
require 'test_helper'

class IndicatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
