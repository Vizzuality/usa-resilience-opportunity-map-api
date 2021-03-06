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

      attributes :name, :description, :slug, :relevant, :labels,
                 :legend_states, :legend_countries, :legend_tracts, :legend_title, :parent_id

      has_one :category
      has_many :indicator_datum

      filters :name, :slug
    end
  end
end
