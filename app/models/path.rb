class Path < ActiveRecord::Base
  belongs_to :point1, class_name: "Point"
  belongs_to :point2, class_name: "Point"

  validates :point1, :point2, :distance, presence: true
  validate :points_belongs_to_same_location, :if => :has_points?

  def has_points?
    point1.present? && point2.present?
  end

  def points_belongs_to_same_location
    if point1.location != point2.location
      errors.add(:point2, "does not belongs to #{point1.location.name}")
    end
  end

end