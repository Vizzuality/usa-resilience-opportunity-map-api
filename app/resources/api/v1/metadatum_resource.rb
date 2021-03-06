# == Schema Information
#
# Table name: metadata
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  source      :jsonb
#  aditional   :jsonb
#  links       :jsonb
#  layer_id    :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module Api
  module V1
    # Resource for Metadatum
    class MetadatumResource < ApplicationResource
      caching
      immutable

      attributes :title, :description, :source, :aditional,
                 :links

      has_one :layer
    end
  end
end
