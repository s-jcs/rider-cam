# frozen_string_literal: true

require 'pry-byebug'
require './lib/rider_cam/drive.rb'

module RiderCam

  def self.upload_files(dir = './tmp/uploads/')
    drive = RiderCam::Drive.new

    Dir[File.join(dir, '*.png')].each do |file_path|
      file = drive.service.create_file(
        { name: "#{DateTime.now.to_s}.png" },
        fields: 'id',
        upload_source: file_path,
        content_type: 'image/png'
      )
      
      puts "uploaded: #{file.id}"
      File.delete(file_path)
    end
  end
end