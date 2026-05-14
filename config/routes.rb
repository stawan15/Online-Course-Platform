Rails.application.routes.draw do
  devise_for :users

  resources :courses do
    member do
      get :log
      post :restore
    end
  end
  resources :lessons do
    member do
      post :restore
    end
  end
  resources :quizzes do
    member do
      post :restore
      patch :submit_answer
    end
  end
  resources :enrollments do
    member do
      post :restore
    end
  end
  resources :profiles do
    member do
      post :restore
    end
  end
  resources :users do
    member do
      post :restore
    end
  end

  namespace :api do
    namespace :v1 do
      resources :lessons, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :deleted_lessons
        end

       member do
        get :log
        post :restore
       end
      end
      resources :quizzes, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :deleted_quizzes
        end

       member do
        get :log
        post :restore
       end
      end
      resources :enrollments, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :deleted_enrollments
        end

       member do
        get :log
        post :restore
       end
      end
      resources :profiles, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :deleted_profiles
        end

       member do
        get :log
        post :restore
       end
      end
      resources :users, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :deleted_users
        end

       member do
        get :log
        post :restore
       end
      end
      resources :courses, only: [ :index, :show, :create, :update, :destroy ] do
        collection do
          get :deleted_courses
        end

       member do
        get :log
        post :restore
       end
      end
    end
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root "home#index"
end
