DelayedJobsManagement::Engine.routes.draw do
  root 'jobs#overview'

  get 'overview' => 'jobs#overview'

  resources :jobs, only: [:index] do
    delete :remove
    post :requeue
    post :reload
  end
  resources :recurring_jobs, only: [:update]
end
