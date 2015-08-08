class Temperature < ActiveRecord::Base
  def self.today_measurement
    where('created_at > ?' , Time.now.to_date)
  end
end
