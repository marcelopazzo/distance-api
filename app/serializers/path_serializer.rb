class PathSerializer < ActiveModel::Serializer
  attributes :id, :distance
  has_one :point1
  has_one :point2
end
