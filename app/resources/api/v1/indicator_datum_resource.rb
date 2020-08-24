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
module Api
  module V1
    # Resource for IndicatorDatum
    class IndicatorDatumResource < ApplicationResource
      caching
      immutable

      attributes :hazard_value, :absolute_value, :normalized_value

      has_one :category
      has_one :geometry
      has_one :indicator
    end
  end
end
