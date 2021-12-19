# frozen_string_literal: true

require './lib/rider_cam/drive.rb'
require 'rpi_gpio'

module RiderCam
  class << self
    def capture_or_upload
      drive = RiderCam::Drive.new
      capturing = false
      sleep(5)

      # NOTE: run LED
      RPi::GPIO.set_numbering :board
      RPi::GPIO.setup 40, as: :output
      pwm = RPi::GPIO::PWM.new(40, 1)
      pwm.start 50
      
      loop do
        if drive.net_connected?
          pwm.frequency = 10
          system('pkill raspivid')
          capturing = false
          drive.upload_files if drive.uploadable_files?
        else
          next if capturing
          pwm.frequency = 1
          system("raspivid -n -b 250000 \
                 -fps 3 -t 0 -w 640 -h 480 \
                 -o ./tmp/uploads/#{DateTime.now.to_s}.mp4")
          capturing = true
        end
        sleep(10)
      end
    end
  end
end
