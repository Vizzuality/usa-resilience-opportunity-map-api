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
class Widget < ApplicationRecord
  belongs_to :layer
end
