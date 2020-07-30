# == Schema Information
#
# Table name: widgets
#
#  id          :bigint           not null, primary key
#  name        :string
#  widget_type :string
#  source      :jsonb
#  config      :jsonb
#  layer_id    :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Api
  module V1
    # Resource for Indicator
    class WidgetResource < ApplicationResource
      caching
      immutable

      attributes :name, :widget_type,
                 :source, :config

      has_one :layer

      filters :name
    end
  end
end
