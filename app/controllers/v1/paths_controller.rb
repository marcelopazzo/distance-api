class V1::PathsController < ApplicationController
  before_action :set_location
  before_action :set_path, only: [:show, :update, :destroy]

  # GET locations/:location_id/paths
  def index
    @paths = @location.paths

    render json: @paths
  end

  # GET locations/:location_id/paths/1
  def show
    if @path.present?
      render json: @path
    else
      head :not_found
    end
  end

  # POST locations/:location_id/paths
  def create
    create_resource(Path.new(path_params), Proc.new { |r| path_url(r) })
  end

  # PATCH/PUT locations/:location_id/paths/1
  def update
    update_resource(@path, path_params)
  end

  # DELETE locations/:location_id/paths/1
  def destroy
    @path.destroy if @path.present?

    head :no_content
  end

  private

    def set_path
      @path = Path.find(params[:id]) if exists? params[:id]
    end

    def exists?(id)
      @location.paths.collect(&:id).include? id.to_i
    end

    def set_location
      @location = Location.find_by_id_or_name(params[:location_id])
    end

    def path_params
      params.permit(:point1_id, :point2_id, :distance)
    end

    def path_url(path)
      location_path_path(location_id: path.point1.location_id, id: path.id)
    end
end
