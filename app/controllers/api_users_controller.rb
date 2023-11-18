# frozen_string_literal: true

class ApiUsersController < ApplicationController
  before_action :set_api_user, only: [:edit, :update, :destroy]

  # GET /apiusers
  def index
    @apiusers = ApiUser.all.order("created_at ASC").page(@page)
    respond_to do |format|
      format.html
      format.xml  { render xml: ApiUser.all }
      format.json { render json: ApiUser.all }
    end
  end

  # GET /apiusers/new
  def new
    @apiuser = ApiUser.new
  end

  # GET /apiusers/1/edit
  def edit
  end

  # POST /apiusers
  def create
    @apiuser = ApiUser.new(apiuser_params)

    if @apiuser.save
      redirect_to apiusers_path, notice: "ApiUser was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /apiusers/1
  def update
    if @apiuser.update(apiuser_params)
      redirect_to api_users_path, notice: "ApiUser was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /apiusers/1
  def destroy
    @apiuser.destroy
    redirect_to api_users_url, notice: "ApiUser was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_user
      @apiuser = ApiUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def apiuser_params
      params.require(:api_user).permit(:email, :password)
    end
end
