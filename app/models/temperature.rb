class Temperature < ActiveRecord::Base

  def self.today_measurement
    where('created_at > ?' , Time.now.to_date)
  end

  def self.measurement_on_date(year, month, day)
    stamp = DateTime.new(year.to_i, month.to_i, day.to_i)
    where("created_at>=(?) AND created_at<=(?)", stamp, stamp.end_of_day)
  end
end
