class V1::PathsController < ApplicationController
  before_action :set_path, only: [:show, :update, :destroy]

  # GET locations/:location_id/paths
  def index
    @paths = Path.all

    render json: @paths
  end

  # GET locations/:location_id/paths/1
  def show
    render json: @path
  end

  # POST locations/:location_id/paths
  def create
    @path = Path.new(path_params)

    if @path.save
      render json: @path, status: :created, location: path_url(@path)
    else
      render json: @path.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT locations/:location_id/paths/1
  def update
    @path = Path.find(params[:id])

    if @path.update(path_params)
      head :no_content
    else
      render json: @path.errors, status: :unprocessable_entity
    end
  end

  # DELETE locations/:location_id/paths/1
  def destroy
    @path.destroy

    head :no_content
  end

  private

    def set_path
      @path = Path.find(params[:id])
    end

    def path_params
      params.permit(:point1_id, :point2_id, :distance)
    end

    def path_url(path)
      location_path_path(location_id: path.point1.location_id, id: path.id)
    end
end
