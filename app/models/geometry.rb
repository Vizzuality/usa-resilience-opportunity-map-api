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
#  state_fp      :integer
#  county_fp     :integer
#  geojson       :jsonb
#  properties    :jsonb
#
class Geometry < ApplicationRecord
  has_many :children, class_name: 'Geometry', foreign_key: :parent_id
  enum location_type: {county: 1, state: 2}

  validates_presence_of :name, :gid, :location_type

  scope :by_name, ->(string) { where('name ILIKE ?', "%#{string}%")}
end
