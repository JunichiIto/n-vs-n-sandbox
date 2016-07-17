require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "should create project" do
    user = User.create! name: 'Alice', email: 'alice@example.com'
    assert_difference('user.projects.count', 1) do
      post :create, project: { name: 'Awesome project', body: 'Awesome description' }
    end
    project = user.projects.last
    assert_equal 'Awesome project', project.name
    assert_equal 'Awesome description', project.body
    assert_redirected_to project_path(project)
  end

  test "should validate project" do
    user = User.create! name: 'Alice', email: 'alice@example.com'
    assert_no_difference('user.projects.count') do
      post :create, project: { name: '', body: '' }
    end
    assert_response :success
  end
end
