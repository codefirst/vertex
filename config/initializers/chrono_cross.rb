Schedule.where.not(cron: nil).find_each do |s|
  ChronoCross::JobManager.register(s.id.to_s, s.cron, NotifyJob, s.id) unless s.cron.blank?
end rescue nil
