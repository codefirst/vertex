require 'rails_helper'

RSpec.describe "tasks/new", :type => :view do
  before(:each) do
    assign(:task, Task.new(
      :title => "MyString",
      :row_order => 1,
      :user_id => 1,
      :done => false
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_title[name=?]", "task[title]"

      assert_select "input#task_row_order[name=?]", "task[row_order]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_done[name=?]", "task[done]"
    end
  end
end
