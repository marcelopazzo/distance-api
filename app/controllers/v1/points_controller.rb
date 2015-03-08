class V1::PointsController < ApplicationController
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
    @point = Point.new(point_params)

    if @point.save
      render json: @point, status: :created
    else
      render json: @point.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT locations/:location_id/points/1
  def update
    if @point.present?
      if @point.update(point_params)
        head :no_content
      else
        render json: @point.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  # DELETE locations/:location_id/points/1
  def destroy
    @point.destroy

    head :no_content
  end

  private

    def set_point
      @point = location_points.find(params[:id]) if exists? params[:id]
    end

    def exists?(id)
      location_points.exists? id
    end

    def location_points
      Point.by_location params[:location_id]
    end

    def point_params
      params.permit(:name, :location_id)
    end
end
