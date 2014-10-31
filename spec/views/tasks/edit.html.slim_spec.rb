require 'rails_helper'

RSpec.describe "tasks/edit", :type => :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :title => "MyString",
      :row_order => 1,
      :user_id => 1,
      :done => false
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input#task_title[name=?]", "task[title]"

      assert_select "input#task_row_order[name=?]", "task[row_order]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_done[name=?]", "task[done]"
    end
  end
end
