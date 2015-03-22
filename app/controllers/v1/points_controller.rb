class V1::PointsController < ApplicationController
  before_action :set_location
  before_action :set_point, only: [:show, :update, :destroy]

  # GET locations/:location_id/points
  def index
    @points = location_points

    render json: @points
  end

  # GET locations/:location_id/points/1
  def show
    if @point.present?
      render json: @point
    else
      head :not_found
    end
  end

  # POST locations/:location_id/points
  def create
    create_resource(Point.new(point_params), Proc.new { |r| point_url(r) })
  end

  # PATCH/PUT locations/:location_id/points/1
  def update
    update_resource(@point, point_params)
  end

  # DELETE locations/:location_id/points/1
  def destroy
    @point.destroy if @point.present?

    head :no_content
  end

  private

    def set_location
      @location = Location.find_by_id_or_name(params[:location_id])
    end

    def set_point
      @point = location_points.find_by_id_or_name(params[:id])
    end

    def exists?(id)
      location_points.exists?(id) if @location.present?
    end

    def location_points
      @location.points if @location.present?
    end

    def point_params
      params.permit(:name, :location_id)
    end

    def point_url(point)
      location_point_url(location_id: point.location.id, id: point.id)
    end
end
