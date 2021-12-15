# frozen_string_literal: true

require './lib/rider_cam/drive.rb'
require './lib/rider_cam/transcoder.rb'

module RiderCam
  class << self
    def capture_or_upload
      drive = RiderCam::Drive.new
      capturing = false
      sleep(10)
      
      loop do
        if drive.net_connected?
          system('pkill raspivid')
          capturing = false
          drive.upload_files if drive.uploadable_files?
        else
          next if capturing
          system("raspivid -n -b 250000 \
                 -fps 3 -t 0 -w 640 -h 480 \
                 -o ./tmp/uploads/#{DateTime.now.to_s}.mp4")
        end
        sleep(60)
      end
    end
  end
end
