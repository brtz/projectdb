# frozen_string_literal: true

class SecretsController < ApplicationController
  before_action :set_secret, only: [:edit, :update, :destroy]

  # GET /secrets
  def index
    @secrets = Secret.all.page(@page)
    respond_to do |format|
      format.html
      format.xml  { render xml: Secret.all }
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
      redirect_to secrets_path, notice: "Secret was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /secrets/1
  def update
    if @secret.update(secret_params)
      redirect_to secrets_path, notice: "Secret was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /secrets/1
  def destroy
    @secret.destroy
    redirect_to secrets_url, notice: "Secret was successfully deleted."
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_secret
        @secret = Secret.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def secret_params
        params.require(:secret).permit(:name, :content, :environment_id)
      end
end
