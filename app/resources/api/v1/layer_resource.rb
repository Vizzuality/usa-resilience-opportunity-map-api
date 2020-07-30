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
module Api
  module V1
    # Resource for Layer
    class LayerResource < ApplicationResource
      caching
      immutable

      attributes :name, :layer_type, :source, :render,
                 :legend_config

      has_one :category

      filters :name, :layer_type
    end
  end
end
