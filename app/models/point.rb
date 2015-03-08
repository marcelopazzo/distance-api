class Point < ActiveRecord::Base
  belongs_to :location
  validates :name, presence: true
  validates :name, uniqueness: { scope: :location }

  scope :by_location, ->(location_id) { where(:location_id => location_id)}
end
