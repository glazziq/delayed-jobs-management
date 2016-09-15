class Recurring::TestJob < ActiveJob::Base
  include Delayed::RecurringJob
  run_every 1.day

  def perform
    p 'test schedule job'
  end
end
