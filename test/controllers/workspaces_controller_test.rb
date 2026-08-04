require "test_helper"

class WorkspacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @workspace = workspaces(:one)

    sign_in_as @user
  end

  test "should get index" do
    get workspaces_url

    assert_response :success
    assert_select "h1", text: "Your workspaces"
  end

  test "should get show" do
    get workspace_url(@workspace)

    assert_response :success
    assert_select "h1", text: @workspace.name
  end

  test "should get new" do
    get new_workspace_url

    assert_response :success
    assert_select "h1", text: "Create a workspace"
  end

  test "should create workspace" do
    assert_difference("Workspace.count", 1) do
      post workspaces_url, params: {
        workspace: {
          name: "Churchill Web Studio",
          description: "Web design and development projects"
        }
      }
    end

    workspace = Workspace.find_by!(name: "Churchill Web Studio")

    assert_equal @user, workspace.owner
    assert_redirected_to workspace_url(workspace)
  end

  test "should not create workspace without a name" do
    assert_no_difference("Workspace.count") do
      post workspaces_url, params: {
        workspace: {
          name: "",
          description: "Missing workspace name"
        }
      }
    end

    assert_response :unprocessable_entity
  end
  test "should not show another user's workspace" do
  other_users_workspace = workspaces(:two)

  get workspace_url(other_users_workspace)

  assert_response :not_found
end
end