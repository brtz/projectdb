# frozen_string_literal: true

class EnvironmentsController < ApplicationController
  before_action :set_environment, only: [:edit, :update, :destroy]

  # GET /environments
  def index
    @environments = Environment.includes(:project).all.order("created_at ASC").page(@page)
    respond_to do |format|
      format.html
      format.json { render json: Environment.all }
    end
  end

  # GET /environments/new
  def new
    @environment = Environment.new
  end

  # GET /environments/1/edit
  def edit
  end

  # POST /environments
  def create
    return head(:forbidden) unless @current_role == "admin"

    @environment = Environment.new(environment_params)

    if @environment.save
      respond_to do |format|
        format.html { redirect_to environments_path, notice: "Environment was successfully created." }
        format.json { render json: @environment }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { head(:bad_request) }
      end
    end
  end

  # PATCH/PUT /environments/1
  def update
    return head(:forbidden) unless @current_role == "admin"

    if @environment.update(environment_params)
      respond_to do |format|
        format.html { redirect_to environments_path, notice: "Environment was successfully updated." }
        format.json { render json: @environment }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { head(:bad_request) }
      end
    end
  end

  # DELETE /environments/1
  def destroy
    return head(:forbidden) unless @current_role == "admin"

    @environment.destroy
    redirect_to environments_url, notice: "Environment was successfully deleted."
  end

  # GET /environments/spec
  def spec
    render json: Environment.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def environment_params
      params.require(:environment).permit(:page, :name, :description, :shorthandle, :project_id)
    end
end
