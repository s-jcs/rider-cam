# frozen_string_literal: true

require 'pry-byebug'
require 'rider_cam/drive'

module RiderCam

  attr_accessor :drive

  def initialize
    binding.pry
    @drive = RiderCam::Drive.new
  end
end
