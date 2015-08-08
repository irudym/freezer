require 'mqtt'

class Feeder
  def initialize
    puts "::MQTTfeeder v.01"
  end

  def subscribe(server, port)
    MQTT::Client.connect(host: server,port: port) do |msg|
      msg.get('temperature') do |topic, message|
        puts ":::#{topic}/#{message}"
        temp = Temperature.new(value: 230)
        temp.save!
      end
    end
  end
end



namespace :mqttfeeder do
  desc "Get data from mqtt broker and put in DB"
  task dev_feeder: :environment do
    puts 'Start MqttFeeder in development mode'
    feed = Feeder.new
    while(true) do
      feed.subscribe('cloud2logic.com',1883)
    end
  end

  desc "Get data from mqtt broker and put in DB"
  task prod_feeder: :environment do
  end

end
