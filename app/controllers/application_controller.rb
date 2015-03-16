class ApplicationController < ActionController::API
  include ActionController::Serialization

  def default_serializer_options
    { root: false }
  end

  def update_resource(resource, resource_params)
    if resource.present?
      if resource.update(resource_params)
        head :no_content
      else
        render json: resource.errors, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def create_resource(resource, proc)
    if resource.save
      render json: resource, status: :created, location: proc.call(resource)
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end