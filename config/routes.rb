Rails.application.routes.draw do
  resources :requirements do
    resources :proposals
  end

  resources :domain_models do
    member do
      post :replace
    end
  end

  root 'requirements#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
