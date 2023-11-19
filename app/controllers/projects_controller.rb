# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all.order("created_at ASC").page(@page)
    respond_to do |format|
      format.html
      format.xml  { render xml: Project.all }
      format.json { render json: Project.all }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: "Project was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    children = Project.find_by parent_id: @project.id
    if children.nil?
      @project.destroy
      redirect_to projects_url, notice: "Project was successfully deleted."
    else
      respond_to do |format|
        format.html { redirect_to projects_path, alert: "Project has child projects. Delete children first." }
        format.json { redirect_to projects_path, status: 409 }
      end
    end
  end

  # GET /projects/spec
  def spec
    render json: Project.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :shorthandle, :description, :user_id, :parent_id, :custom_id, :start_datetime, :end_datetime)
    end
end
