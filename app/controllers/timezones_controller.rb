class TimezonesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update]
  respond_to :json


  def index
    respond_with Timezone.all
  end


  def show
    respond_with Timezone.find(params[:id])
  end


  def create
    timezone = current_user.timezones.build(timezone_params)

    if timezone.save
      render json: timezone, status: 201, location: [timezone]
    else
      render json: { errors: timezone.errors }, status: 422
    end
  end


  def update
    timezone = current_user.timezones.find(params[:id])
    if timezone.update(timezone_params)
      render json: timezone, status: 200, location: [timezone]
    else
      render json: { errors: timezone.errors }, status: 422
    end
  end


  def destroy
    timezone = current_user.timezones.find(params[:id])
    timezone.destroy
    head 204
  end


  private
    def timezone_params
      params.require(:timezone).permit(:name, :city_id, :gmt_difference)
    end

end
