class Notification < Thor
  desc 'notify [nickname]', 'reset tasks and notify'
  def notify(nickname = nil)
    if nickname.blank?
      User.all.each { |user| user.notify! }
    else
      User.find_by(nickname: nickname)&.notify!
    end
  end

  desc 'cron_notify [nickname]', 'reset task and notify along user notification setting'
  def cron_notify(nickname = nil)
    if nickname.blank?
      User.all.each { |user| notify_by_cron(user) }
    else
      user = User.find_by(nickname: nickname)
      notify_by_cron(user)
    end
  end

  private
  def notify_by_cron(user)
    return if user&.schedule&.cron.blank?

    iter = Chrono::Iterator.new(user.schedule.cron)
    # '10 minutes' is shortest duration of Heroku scheduler
    user.notify! if iter.next - Time.now - 10.minutes < 0
  end
end
