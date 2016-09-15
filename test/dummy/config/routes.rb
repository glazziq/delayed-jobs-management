Rails.application.routes.draw do
  mount DelayedJobsManagement::Engine => "/delayed_jobs_management"
end
