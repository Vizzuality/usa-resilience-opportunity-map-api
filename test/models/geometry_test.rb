# == Schema Information
#
# Table name: geometries
#
#  id            :bigint           not null, primary key
#  geom          :geometry         geometry, 0
#  name          :string           not null
#  description   :text
#  gid           :string           not null
#  location_type :integer          not null
#  parent_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state_fp      :integer
#  county_fp     :integer
#  geojson       :jsonb
#  properties    :jsonb
#  bbox          :jsonb
#  tract_ce      :integer
#
require 'test_helper'

class GeometryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
