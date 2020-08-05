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

# TODO: Fix the typo in additional
class Metadatum < ApplicationRecord
  belongs_to :indicator
end
