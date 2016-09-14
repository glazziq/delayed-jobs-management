module DelayedJobsManagement
  module ApplicationHelper
    def active_class(link_path)
      active = current_page?(link_path) ? "current" : ""
    end
  end
end
