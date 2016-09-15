module DelayedJobsManagement
  class Engine < ::Rails::Engine
    isolate_namespace DelayedJobsManagement

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
