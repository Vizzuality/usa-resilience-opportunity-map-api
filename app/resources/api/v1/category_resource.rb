# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Api
  module V1
    # Resource for Layer
    class CategoryResource < ApplicationResource
      caching
      immutable

      has_many :layers
      attributes :name

      filters :name
    end
  end
end
