class Location < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :points

  scope :find_by_id_or_name, ->(param) { where(by_id(param).or(by_name(param))).first }

  def paths
    points.flat_map &:paths
  end

  private

    def self.locations
      @arel ||= Location.arel_table
    end

    def self.by_id(id)
      locations[:id].eq(id)
    end

    def self.by_name(name)
      locations[:name].eq(name)
    end


end
