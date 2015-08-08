class DashboardController < ApplicationController
  def index
    @data = Temperature.today_measurement
  end
end
