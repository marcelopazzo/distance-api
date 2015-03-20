class V1::LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy, :best_route]
  before_action :set_best_route_params, only: :best_route

  # GET /locations
  def index
    @locations = Location.all

    render json: @locations
  end

  # GET /locations/1
  def show
    if @location.present?
      render json: @location
    else
      head :not_found
    end
  end

  # GET /locations/1/best_route
  def best_route
    if (@source.present? && @destination.present? && @autonomy.present? && @fuel_price.present?)
      graph = Graph.new(@location.points, @location.paths)
      path, distance = graph.shortest_path(@source, @destination)
      result = Result.new(path, distance, @autonomy.to_d, @fuel_price.to_d)
      render json: result, status: :ok
    else
      head :bad_request
    end
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      render json: @location, status: :created, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  def update
    update_resource(@location, location_params)
  end

  # DELETE /locations/1
  def destroy
    @location.destroy if @location.present?

    head :no_content
  end

  private

    def set_location
      @location = Location.find_by_id_or_name(params[:id])
    end

    def load_point(id)
      @location.points.find(id) if @location.points.exists?(id)
    end

    def location_params
      params.permit(:name)
    end

    def set_best_route_params
      @source = load_point params[:source_id]
      @destination = load_point params[:destination_id]
      @autonomy = params[:autonomy]
      @fuel_price = params[:fuel_price]
    end
end
