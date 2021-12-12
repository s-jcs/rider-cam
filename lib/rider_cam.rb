# frozen_string_literal: true

require './lib/rider_cam/drive.rb'
require './lib/rider_cam/compressor.rb'

module RiderCam
  class << self
    def check_and_upload_files
      drive = RiderCam::Drive.new
      drive.upload_files
    end

    def try_comp
      RiderCam::Compressor.new.transcode
    end
  end
end