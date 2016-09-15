[![Build Status](https://travis-ci.org/glazziq/delayed-jobs-management.svg?branch=master)](https://travis-ci.org/glazziq/delayed-jobs-management)
[![Code Climate](https://codeclimate.com/github/glazziq/delayed-jobs-management/badges/gpa.svg)](https://codeclimate.com/github/glazziq/delayed-jobs-management)
[![Test Coverage](https://codeclimate.com/github/glazziq/delayed-jobs-management/badges/coverage.svg)](https://codeclimate.com/github/glazziq/delayed-jobs-management/coverage)

# DelayedJobsManagement

## Usage

1 install gem

```ruby
gem 'delayed_jobs_management'
```

2 add routes

```ruby
  mount DelayedJobsManagement::Engine => "/delayed_job"
```

3 *Option* recurring jobs management

```ruby
# config/initailzers/delayed_jobs_management.rb

DelayedJobsManagement.config do |c|
  c.recurring_jobs = [
    { name: 'job_name_1', job: Recurring::ExampleFirstJob },
    { name: 'job_name_2', job: Recurring::ExampleSecondJob }
  ]
end
```

|attr|desc|
|----------|----------|
|`name`| name of recurring job that you want|
|`job`| class name of recurring job|

---

This project rocks and uses MIT-LICENSE.
