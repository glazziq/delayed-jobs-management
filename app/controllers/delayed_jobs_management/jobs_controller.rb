module DelayedJobsManagement
  class JobsController < ApplicationController
    layout 'layouts/delayed_jobs_management/application'

    before_action :set_job, except: [:index, :overview]
    before_action :set_recurring_jobs, only: [:index, :overview]

    def index
      params[:type] ||= :all
      params[:queues] ||= []
      @jobs = delayed_jobs(params[:type], params[:queues])
    end

    def overview
      @enqueued_count = delayed_jobs(:all).count || 0
      @working_count = delayed_jobs(:working).count || 0
      @failed_count = delayed_jobs(:failed).count || 0
      @pending_count = delayed_jobs(:pending).count || 0
    end

    def remove
      @job.delete
      redirect_to :back
    end

    def requeue
      @job.update_attributes(run_at: Time.now, failed_at: nil)
      redirect_to :back
    end

    def reload
      @job.update_attributes(
        run_at: Time.now,
        failed_at: nil,
        locked_by: nil,
        locked_at: nil,
        last_error: nil,
        attempts: 0
      )
      redirect_to :back
    end

    private
    def set_job
      @job = delayed_job.find(params[:job_id])
    end
  end
end
