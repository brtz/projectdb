# frozen_string_literal: true

class SecretsController < ApplicationController
  before_action :set_secret, only: [:edit, :update, :destroy]

  # GET /secrets
  def index
    @secrets = Secret.all.order("created_at ASC").page(@page)
    respond_to do |format|
      format.html
      format.json { render json: Secret.all }
    end
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end

  # GET /secrets/1/edit
  def edit
  end

  # POST /secrets
  def create
    @secret = Secret.new(secret_params)

    if @secret.save
      respond_to do |format|
        format.html { redirect_to secrets_path, notice: "Secret was successfully created." }
        format.json { render json: @secret }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { head(:bad_request) }
      end
    end
  end

  # PATCH/PUT /secrets/1
  def update
    if @secret.update(secret_params)
      respond_to do |format|
        format.html { redirect_to secrets_path, notice: "Secret was successfully updated." }
        format.json { render json: @secret }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { head(:bad_request) }
      end
    end
  end

  # DELETE /secrets/1
  def destroy
    @secret.destroy
    redirect_to secrets_url, notice: "Secret was successfully deleted."
  end

  # GET /secrets/spec
  def spec
    render json: Secret.new
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_secret
        @secret = Secret.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def secret_params
        params.require(:secret).permit(:page, :name, :content, :environment_id)
      end
end
