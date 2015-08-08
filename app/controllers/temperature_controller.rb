class TemperatureController < ApplicationController

  ## return data for the date
  def get_data
    data = Temperature.today_measurement

    #get every hour measurement
    #get the first record timestamp
    start = data.to_a[0][:created_at]


    render json: Temperature.today_measurement

  end

  private
    def get_permitted_params
      params.require(:temperature).permit(:date)
    end
end
