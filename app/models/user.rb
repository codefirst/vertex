class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :omniauthable

  has_many :tasks
  has_one :schedule
  has_one :notification

  def notify!
    tasks = self.tasks.rank(:row_order)
    unless tasks.empty?
      tasks.update_all(done: false)
      content = "\n" + tasks.map {|task| " - #{task.title}"}.join("\n")
      notifier.notify(content)
    end
  end

  def done_notify
    notifier.notify("#{self.name} has finished all tasks on Vertex!")
  end

  private
  def notifier
    if notification and notification.is_line?
      Vertex::Line.new(notification.token)
    end
  end
end
