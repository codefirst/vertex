module Vertex
  class Taskpaper
    def report(user, tasks)
      content = "taskpaper::\n"
      content << user.name << ":\n"
      tasks.each do |task|
        content << " - #{task.title}\n"
      end
      content
    end
  end
end

