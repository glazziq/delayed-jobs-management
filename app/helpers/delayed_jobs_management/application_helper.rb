module DelayedJobsManagement
  module ApplicationHelper
    def active_class(link_path)
      active = current_page?(link_path) ? "current" : ""
    end

    def display_run_interval(recurring_job_class)
      seconds = recurring_job_class.run_every
      minutes, seconds = seconds.divmod(60)
      hours, minutes = minutes.divmod(60)
      days, hours = hours.divmod(24)
      weeks, days = days.divmod(7)
      interval = {
        seconds: { value: seconds, suffix: 'seconds' },
        minutes: { value: minutes, suffix: 'minutes' },
        hours: { value: hours, suffix: 'hours' },
        days: { value: days, suffix: 'days' },
        weeks: { value: weeks, suffix: 'weeks' }
      }
      display_interval = interval.map do |_unit, data|
        next if data[:value].zero?
        "#{data[:value]} #{data[:suffix]}"
      end.join(' ')

      text = ''
      text += "every #{display_interval}" if display_interval.present?
      text += " at #{recurring_job_class.run_at.join(', ')}" \
        if recurring_job_class.run_at.present?
      text += " (#{recurring_job_class.timezone})" \
        if recurring_job_class.timezone.present?
      text = '----=> ' + text if text.present?
      text
    end
  end
end
