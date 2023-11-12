class EnvironmentsController < ApplicationController
  before_action :set_environment, only: [:edit, :update, :destroy]

  # GET /environments
  def index
    @environments = Environment.all.page(@page)
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
    @environment = Environment.new(environment_params)

    if @environment.save
      redirect_to environments_path, notice: 'Environment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /environments/1
  def update
    if @environment.update(environment_params)
      redirect_to environments_path, notice: 'Environment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /environments/1
  def destroy
    @environment.destroy
    redirect_to environments_url, notice: 'Environment was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def environment_params
      params.require(:environment).permit(:name, :description, :shorthandle, :project_id)
    end
end
