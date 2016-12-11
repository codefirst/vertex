class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :omniauthable

  has_many :tasks
  has_one :schedule
  has_one :line_access_token

  def notify!
    tasks = self.tasks.rank(:row_order)
    unless tasks.empty?
      tasks.update_all(done: false)
      content = Vertex::Taskpaper.new.report(self, tasks)
      notifiers.each do |notifier|
        notifier.notify(content)
      end
    end
  end

  def done_notify
    notifiers.each do |notifier|
      notifier.notify("#{self.name} has finished all tasks on Vertex!")
    end
  end

  private
  def notifiers
    clients = [Vertex::AsakusaSatellite.new]
    clients << Vertex::Line.new(line_access_token.token) if line_access_token
    clients
  end
end
