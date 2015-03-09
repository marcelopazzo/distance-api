class Result
  include ActiveModel::SerializerSupport
  attr_reader :path, :cost

  def initialize(path, distance, autonomy, fuel_price)
    @path = path
    @cost = distance*fuel_price/autonomy
  end
end