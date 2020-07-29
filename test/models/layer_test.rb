# == Schema Information
#
# Table name: layers
#
#  id            :bigint           not null, primary key
#  name          :string
#  layer_type    :string
#  source        :jsonb
#  render        :jsonb
#  legend_config :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :bigint           not null
#
require 'test_helper'

class LayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
