class TemperatureController < ApplicationController

  ## return data for the date
  def get_data
    render json: Temperature.today_measurement
  end

  private
    def get_permitted_params
      params.require(:temperature).permit(:date)
    end
end
