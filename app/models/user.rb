class User < ActiveRecord::Base
  devise :omniauthable

  has_many :tasks

  def notify!
    tasks = Task.where("user_id = ?", self.id)
    unless tasks.empty?
      tasks.update_all(done: false)
      content = Vertex::Taskpaper.new.report(self, self.tasks)
      Vertex::AsakusaSatellite.new.notify(content)
    end
  end
end
