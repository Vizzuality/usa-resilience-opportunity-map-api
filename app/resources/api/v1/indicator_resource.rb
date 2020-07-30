# == Schema Information
#
# Table name: indicators
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Api
  module V1
    # Resource for Indicator
    class IndicatorResource < ApplicationResource
      caching
      immutable

      attributes :name, :description, :slug

      filters :name, :slug
    end
  end
end
