class WorkspacesController < ApplicationController
  before_action :set_workspace, only: :show

  def index
    @workspaces = Current.user.owned_workspaces.order(created_at: :desc)
  end

  def show
  end

  def new
    @workspace = Current.user.owned_workspaces.new
  end

  def create
    @workspace = Current.user.owned_workspaces.new(workspace_params)

    if @workspace.save
      redirect_to @workspace, notice: "Workspace created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_workspace
    @workspace = Current.user.owned_workspaces.find(params[:id])
  end

  def workspace_params
    params.expect(workspace: [:name, :description])
  end
end