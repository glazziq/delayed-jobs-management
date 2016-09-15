require "delayed_jobs_management/engine"

module DelayedJobsManagement
  class << self
    attr_accessor :recurring_jobs

    def config &block
      instance_eval(&block)  if block_given?
    end

    def recurring_jobs
      @recurring_jobs || []
    end

    def delayed_job_version
      Gem.loaded_specs['delayed_job'].try(:version).try(:to_s)
    end

    def enabled_recurring_jobs?
      DelayedJobsManagement.delayed_job_recurring_version.present?
    end

    def delayed_job_recurring_version
      Gem.loaded_specs['delayed_job_recurring'].try(:version).try(:to_s)
    end
  end
end
