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
class Geometry < ApplicationRecord
end
