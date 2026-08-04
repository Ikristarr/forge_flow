require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  test "is valid with a name and owner" do
    workspace = Workspace.new(
      name: "Northstar Agency",
      owner: users(:one)
    )

    assert workspace.valid?
  end

  test "requires a name" do
    workspace = Workspace.new(owner: users(:one))

    assert_not workspace.valid?
    assert_includes workspace.errors[:name], "can't be blank"
  end

  test "requires an owner" do
    workspace = Workspace.new(name: "Northstar Agency")

    assert_not workspace.valid?
    assert_includes workspace.errors[:owner], "must exist"
  end

  test "appears among the owner's workspaces" do
    owner = users(:one)

    assert_includes owner.owned_workspaces, workspaces(:one)
  end
end