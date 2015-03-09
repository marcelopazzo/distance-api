class Path < ActiveRecord::Base
  belongs_to :point1, class_name: "Point"
  belongs_to :point2, class_name: "Point"

  validates :point1, :point2, :distance, presence: true
  validates :distance, numericality: { greater_than: 0 }

  validate :points_belongs_to_same_location,
    :path_is_unique_in_other_direction, :if => :has_points?

  def has_points?
    point1.present? && point2.present?
  end

    private

    def points_belongs_to_same_location
      if point1.location != point2.location
        errors.add(:point2, "does not belongs to #{point1.location.name}")
      end
    end

    def path_is_unique_in_other_direction
      if path_already_exists?
        errors.add(:point2, "a path already exists between #{point1.name} and #{point2.name}")
      end
    end

    def path_already_exists?
      Path.where("(point1_id = #{point2.id} and point2_id = #{point1.id}) OR (point1_id = #{point1.id} and point2_id = #{point2.id})").where.not(id: id).exists?
    end

end