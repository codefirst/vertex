class Notification < Thor
  desc 'notify [nickname]', 'reset tasks and notify'
  def notify(nickname = nil)
    if nickname.blank?
      User.all.each { |user| user.notify! }
    else
      User.find_by(nickname: nickname).notify!
    end
  end
end
