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
#
module Api
  module V1
    # Resource for Area
    class GeometryResource < ApplicationResource
      caching
      immutable

      has_many :children
      attributes :geom, :name, :description, :gid, :location_type

      filters :gid, :location_type

      filter :name, apply: lambda { |records, value, _options|
        records.where('name ILIKE ?', "%#{value.first}%")
      }
    end
  end
end