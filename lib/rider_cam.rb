# frozen_string_literal: true

require 'pry-byebug'
require 'lib/rider_cam/drive'

module RiderCam
  def upload_files(dir = 'tmp/uploads/')
    drive = RiderCam::Drive.new
    file = drive.service.create_file(
      { name: 'photo.jpg' },
      fields: 'id',
      uplaod_source: dir,
      content_type: 'image/jpeg'
    )

    puts "Uploaded: #{file.id}"
  end
end