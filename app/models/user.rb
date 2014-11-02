class User < ActiveRecord::Base
  devise :omniauthable

  has_many :tasks

  def notify!
    Task.where("user_id = ?", self.id).update_all(done: false)
    content = Vertex::Taskpaper.new.report(self, self.tasks)
    Vertex::AsakusaSatellite.new.notify(content)
  end
end
