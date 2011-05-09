require 'test_helper'

class ProjectPrereqsControllerTest < ActionController::TestCase
  setup do
    @project_prereq = project_prereqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_prereqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_prereq" do
    assert_difference('ProjectPrereq.count') do
      post :create, :project_prereq => @project_prereq.attributes
    end

    assert_redirected_to project_prereq_path(assigns(:project_prereq))
  end

  test "should show project_prereq" do
    get :show, :id => @project_prereq.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @project_prereq.to_param
    assert_response :success
  end

  test "should update project_prereq" do
    put :update, :id => @project_prereq.to_param, :project_prereq => @project_prereq.attributes
    assert_redirected_to project_prereq_path(assigns(:project_prereq))
  end

  test "should destroy project_prereq" do
    assert_difference('ProjectPrereq.count', -1) do
      delete :destroy, :id => @project_prereq.to_param
    end

    assert_redirected_to project_prereqs_path
  end
end
