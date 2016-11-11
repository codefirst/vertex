require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'notify' do
    it {
      mock_notifiers = [double(Vertex::AsakusaSatellite), double(Vertex::Line)]
      message = "taskpaper::\ntest user:\n - task3\n - task2\n - task1\n"
      mock_notifiers.each do |mock_notifier|
        allow(mock_notifier).to receive(:notify).with(message)
      end
      user = User.create(nickname: 'testuser', name: 'test user')
      allow(user).to receive(:notifiers).and_return(mock_notifiers)
      user.tasks << Task.create(title: 'task1', row_order: 3)
      user.tasks << Task.create(title: 'task2', row_order: 2)
      user.tasks << Task.create(title: 'task3', row_order: 1)
      user.notify!
    }
  end
end
