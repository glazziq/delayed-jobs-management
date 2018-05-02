require 'rails_helper'

class RecurringTestJob < ActiveJob::Base
  include Delayed::RecurringJob
  run_every 1.day

  def perform
    p 'test schedule job'
  end
end

describe DelayedJobsManagement::RecurringJobsController, type: :controller do
  routes { DelayedJobsManagement::Engine.routes }

  let(:scheduled_job) { @scheduled_job = { name: 'test_schedule_job', job: RecurringTestJob } }

  before do
    DelayedJobsManagement.config do |c|
      c.recurring_jobs = [{ name: 'test_schedule_job', job: RecurringTestJob }]
    end
  end

  describe 'PUT #update' do
    context 'start scheduled' do
      it 'create scheduled job and first delayed job' do
        expect {
          get :update, { id: scheduled_job[:job] }
        }.to change(Delayed::Job, :count).by(2)
      end
    end
    context 'stop scheduled' do
      it 'remove scheduled job' do
        get :update, { id: scheduled_job[:job] } # start scheduled
        expect {
          get :update, { id: scheduled_job[:job] }
        }.to change(Delayed::Job, :count).by(-1)
      end
    end
  end
end
