class TemperatureController < ApplicationController

  ## return data for the date
  def get_data
    unless params[:year]
      data = Temperature.today_measurement
    else
      data = Temperature.measurement_on_date(params[:year],
                                             params[:month],
                                             params[:day])
    end

    #get every hour measurement
    #get the first record timestamp
    data = data || []
    start = data.to_a[0][:created_at]
    start_hour = start.hour
    start_hour += 1 if start.min > 40
    temp_data = Array.new(start_hour, 0)

    hour = start_hour
    temp_data += data.collect do |value|
      #puts "=> check: #{value[:value]} | #{value[:created_at]} <> #{hour}"
      if value[:created_at].hour >= hour
        white = nil
        if(value[:created_at].hour - hour > 1)
          white = Array.new(value[:created_at].hour - hour, 0)
        end
        hour = value[:created_at].hour + 1
        #puts "=>\tadd: #{value[:value]} | #{value[:created_at]}"
        res = value[:value]/10
        if white
          res = white << res
        end
        res
      end
    end.compact

    render json: temp_data.flatten
  end

  private
    def get_permitted_params
      params.require(:temperature).permit(:year, :hour, :min)
    end
end
