class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :omniauthable

  has_many :tasks
  has_one :schedule

  def notify!
    tasks = self.tasks.rank(:row_order)
    unless tasks.empty?
      tasks.update_all(done: false)
      content = Vertex::Taskpaper.new.report(self, tasks)
      notifier.notify(content)
    end
  end

  def done_notify
    notifier.notify("#{self.name} has finished all tasks on Vertex!")
  end

  private
  def notifier
    Vertex::AsakusaSatellite.new
  end
end
