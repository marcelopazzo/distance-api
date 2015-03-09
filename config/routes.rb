Rails.application.routes.draw do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
    resources :locations, except: [:new, :edit] do
      resources :points, except: [:new, :edit]
      resources :paths, except: [:new, :edit]
      get 'best_route', on: :member
    end
  end

  root to: redirect('/locations')
end
