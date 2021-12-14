# frozen_string_literal: true

require './lib/rider_cam/drive.rb'
require './lib/rider_cam/transcoder.rb'

module RiderCam
  class << self
    def check_and_upload_files
      drive = RiderCam::Drive.new
      drive.upload_files
    end

    def transcode_images
      loop do
        RiderCam::Transcoder.convert
        sleep(5)
      end
    end
  end
end