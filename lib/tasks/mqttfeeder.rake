require 'mqtt'

class Feeder
  def initialize
    puts "::MQTTfeeder v.01"
  end

  def subscribe(server, port)
    MQTT::Client.connect(host: server,port: port) do |msg|
      msg.get('temp') do |topic, message|
        puts ":::#{topic}/#{message}"
        temp = Temperature.new(value: message)
        temp.save!
      end
    end
  end
end



namespace :mqttfeeder do
  desc "Get data from mqtt broker and put in DB"
  task feeder: :environment do
    puts 'Start MqttFeeder in development mode'
    feed = Feeder.new
    while(true) do
      feed.subscribe('cloud2logic.com',1883)
    end
  end
end
