DelayedJobsManagement.config do |c|
  c.recurring_jobs = [{ name: 'test_schedule_job', job: Recurring::TestJob }]
end
