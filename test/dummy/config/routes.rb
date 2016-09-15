Rails.application.routes.draw do
  mount DelayedJobsManagement::Engine => "/delayed_jobs_management"

  root 'application#test_job'
end
