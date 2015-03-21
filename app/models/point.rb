class Point < ActiveRecord::Base
  belongs_to :location
  validates :name, presence: true
  validates :name, uniqueness: { scope: :location }
  has_many :paths, foreign_key: "point1_id"

  scope :by_location, ->(location_id) { where(:location_id => location_id)}

  def self.find_by_id_or_name(param)
    where(by_id(param).or(by_name(param))).first
  end

  private

    def self.points
      @arel ||= Point.arel_table
    end

    def self.by_id(id)
      points[:id].eq(id)
    end

    def self.by_name(name)
      points[:name].eq(name)
    end
end
