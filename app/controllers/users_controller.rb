# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all.order("created_at ASC").page(@page)
    respond_to do |format|
      format.html
      format.xml  { render xml: User.all }
      format.json { render json: User.all }
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    return head(:forbidden) unless @current_role == "admin"

    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    return head(:forbidden) unless @current_role == "admin"

    return head(:conflict) if @user.id == @current_user.id

    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    return head(:forbidden) unless @current_role == "admin"

    return head(:conflict) if @user.id == @current_user.id

    projects = Project.find_by user_id: @user.id
    if projects.nil?
      @user.destroy
      redirect_to users_url, notice: "User was successfully deleted."
    else
      respond_to do |format|
        format.html { redirect_to users_path, alert: "User has projects. Re-assign projects first." }
        format.json { redirect_to users_path, status: 409 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
