Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :sections, only: [ :index, :show ]

      resources :students, only: [] do
        member do
          # GET /api/v1/students/:id/schedule
          get "schedule", to: "students#schedule"
          # POST /api/v1/students/:id/sections/:section_id
          post "sections/:section_id", to: "students#add_section"
          # DELETE /api/v1/students/:id/sections/:section_id
          delete "sections/:section_id", to: "students#remove_section"
        end
      end
    end
  end
end
