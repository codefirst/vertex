require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'notify' do
    it {
      mock_notifier = double(Vertex::AsakusaSatellite)
      allow(mock_notifier).to receive(:notify).with("taskpaper::\ntest user:\n - task3\n - task2\n - task1\n")
      user = User.create(nickname: 'testuser', name: 'test user')
      allow(user).to receive(:notifier).and_return(mock_notifier)
      user.tasks << Task.create(title: 'task1', row_order: 3)
      user.tasks << Task.create(title: 'task2', row_order: 2)
      user.tasks << Task.create(title: 'task3', row_order: 1)
      user.notify!
    }
  end
end
