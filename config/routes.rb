Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :api do
    namespace :v1 do
      post '/validate_id', to: 'identity_validation#validate'
      get '/health', to: 'health#check'
      get '/pricing', to: 'pricing#index'

      resources :billing, only: [] do
        collection do
          get 'monthly_summary'
          get 'credit_balance'
        end
      end

      resources :reports, only: [] do
        collection do
          get 'usage'
          get 'trends'
        end
      end
    end
  end
end
