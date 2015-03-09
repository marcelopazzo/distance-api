class Location < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :points

  def paths
    points.flat_map &:paths
  end

end
