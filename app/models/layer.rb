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
class Layer < ApplicationRecord
  belongs_to :category
  has_one :metadatum
end
