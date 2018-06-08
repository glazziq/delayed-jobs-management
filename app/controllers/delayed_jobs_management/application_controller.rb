class DelayedJobsManagement::ApplicationController < ActionController::Base
  layout 'layouts/delayed_jobs_management/application'

  protected

  def delayed_job
    Delayed::Job
  rescue
    false
  end

  def delayed_jobs(type, queues = [])
    type = type.to_sym
    rel = delayed_job
    rel = case type
          when :working
            rel.where.not(locked_at: nil)
          when :failed
            rel.where.not(last_error: nil)
          when :pending
            rel.where(attempts: 0, locked_at: nil)
          else
            rel.all
          end
    rel = rel.where(queue: queues) unless queues.empty?
    rel
  end

  def set_recurring_jobs
    @recurring_jobs = DelayedJobsManagement.recurring_jobs.map do |job|
      OpenStruct.new(job)
    end
  end
end
