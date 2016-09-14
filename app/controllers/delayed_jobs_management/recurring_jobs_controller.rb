module DelayedJobsManagement
  class RecurringJobsController < ApplicationController
    layout 'layouts/delayed_jobs_management/application'

    before_action :set_recurring_jobs

    def update
      @recurring_job = @recurring_jobs.find { |job| job.name == params[:id] }&.job
      @recurring_job&.scheduled? ? @recurring_job&.unschedule : @recurring_job&.schedule!
      redirect_to overview_url
    end
  end
end
