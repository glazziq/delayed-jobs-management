require 'rails_helper'

describe DelayedJobsManagement::JobsController, type: :controller do
  routes { DelayedJobsManagement::Engine.routes }

  describe 'GET #index' do
    let!(:working_jobs) { create_list(:delayed_job, 2, :working) }
    let!(:pending_jobs) { create_list(:delayed_job, 2, :pending) }
    let!(:failed_jobs) { create_list(:delayed_job, 2, :failed) }

    it 'return status 200' do
      get :index
      expect(response.status).to eq 200
    end

    it 'return all jobs by default' do
      get :index
      expect(assigns(:jobs)).to match_array(working_jobs + pending_jobs + failed_jobs)
    end

    it 'return working jobs' do
      get :index, { type: :working }
      expect(assigns(:jobs)).to match_array(working_jobs)
    end

    it 'return pending jobs' do
      get :index, { type: :pending }
      expect(assigns(:jobs)).to match_array(pending_jobs)
    end

    it 'return failed jobs' do
      get :index, { type: :failed }
      expect(assigns(:jobs)).to match_array(failed_jobs)
    end

    describe "recurring jobs" do
      it 'set @recurring_jobs variable if it is enabled' do
        allow(DelayedJobsManagement).to receive(:enabled_recurring_jobs?).and_return(true)
        allow(DelayedJobsManagement).to receive(:recurring_jobs).and_return([])
        get :index
        expect(assigns(:recurring_jobs)).to eq(Array.new)
      end
      it 'not set @recurring_jobs variable if it is disabled' do
        allow(DelayedJobsManagement).to receive(:enabled_recurring_jobs?).and_return(false)
        allow(DelayedJobsManagement).to receive(:recurring_jobs).and_return([])
        get :index
        expect(assigns(:recurring_jobs)).to be_nil
      end
    end
  end

  describe 'GET #overview' do
    let!(:working_jobs) { create_list(:delayed_job, 2, :working) }
    let!(:pending_jobs) { create_list(:delayed_job, 2, :pending) }
    let!(:failed_jobs) { create_list(:delayed_job, 2, :failed) }

    it 'return status 200' do
      get :overview
      expect(response.status).to eq 200
    end

    it 'set enqueued jobs count' do
      get :overview
      expect(assigns(:enqueued_count)).to eq 6
    end

    it 'set working jobs count' do
      get :overview
      expect(assigns(:working_count)).to eq 2
    end

    it 'set pending jobs count' do
      get :overview
      expect(assigns(:pending_count)).to eq 2
    end

    it 'set failed jobs count' do
      get :overview
      expect(assigns(:failed_count)).to eq 2
    end

    describe "recurring jobs" do
      it 'set @recurring_jobs variable if it is enabled' do
        allow(DelayedJobsManagement).to receive(:enabled_recurring_jobs?).and_return(true)
        allow(DelayedJobsManagement).to receive(:recurring_jobs).and_return([])
        get :overview
        expect(assigns(:recurring_jobs)).to eq(Array.new)
      end
      it 'not set @recurring_jobs variable if it is disabled' do
        allow(DelayedJobsManagement).to receive(:enabled_recurring_jobs?).and_return(false)
        get :overview
        expect(assigns(:recurring_jobs)).to be_nil
      end
    end
  end

  describe 'DELETE #remove' do
    let!(:job) { create(:delayed_job) }
    let(:previous_url) { root_url }
    before { request.env["HTTP_REFERER"] = previous_url }

    it 'remove delayed job' do
      expect {
        delete :remove, { job_id: job.id }
      }.to change(Delayed::Job, :count).by(-1)
    end

    it 'redirect to previous page' do
      delete :remove, { job_id: job.id }
      expect(response).to redirect_to previous_url
    end
  end

  describe 'PUT #requeue' do
    let!(:job) { create(:delayed_job, run_at: 2.days.ago, failed_at: 2.days.ago) }
    let(:previous_url) { root_url }
    before { request.env["HTTP_REFERER"] = previous_url }

    context 'update data' do
      before do
        put :requeue, { job_id: job.id }
        job.reload
      end

      it 'run_at to be now' do
        expect(job.run_at).to be_within(1.second).of Time.now
      end

      it 'failed_at to be nil' do
        expect(job.failed_at).to be_nil
      end
    end

    it 'redirect to previous page' do
      put :requeue, { job_id: job.id }
      expect(response).to redirect_to previous_url
    end
  end

  describe 'PUT #reload' do
    let!(:job) { create(:delayed_job,
      run_at: 2.days.ago,
      failed_at: 2.days.ago ,
      locked_by: 'Object',
      locked_at: 2.days.ago,
      last_error: 'Last Errors',
      attempts: 1)
    }
    let(:previous_url) { root_url }
    before { request.env["HTTP_REFERER"] = previous_url }

    context 'update data' do
      before do
        put :reload, { job_id: job.id }
        job.reload
      end
      it 'run_at to be now' do
        expect(job.run_at).to be_within(1.second).of Time.now
      end

      it 'failed_at to be nil' do
        expect(job.failed_at).to be_nil
      end

      it 'locked_by to be nil' do
        expect(job.locked_by).to be_nil
      end

      it 'locked_at to be nil' do
        expect(job.locked_at).to be_nil
      end

      it 'last_error to be nil' do
        expect(job.last_error).to be_nil
      end

      it 'attempts to be 0' do
        expect(job.attempts).to eq 0
      end
    end

    it 'redirect to previous page' do
      put :reload, { job_id: job.id }
      expect(response).to redirect_to previous_url
    end
  end

end
