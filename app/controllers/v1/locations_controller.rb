class V1::LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

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
    if @location.present?
      if @location.update(location_params)
        head :no_content
      else
        render json: @location.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy

    head :no_content
  end

  private

    def set_location
      @location = Location.find(params[:id]) if exists?(params[:id])
    end

    def exists?(id)
      Location.exists? id
    end

    def location_params
      params.permit(:name)
    end
end
