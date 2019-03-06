class Notification < ActiveRecord::Base
  def is_line?
    kind == 'line'
  end

  def self.first_or_default(user)
    Notification.where(user_id: user.id).first || Notification.new(user_id: user.id, kind: 'line', token: '')
  end
end
