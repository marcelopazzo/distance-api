Rails.application.routes.draw do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
    resources :locations, except: [:new, :edit] do
      resources :points, except: [:new, :edit]
    end
  end
end
