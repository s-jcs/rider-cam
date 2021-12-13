# frozen_string_literal: true

require 'date'
require 'streamio-ffmpeg'

module RiderCam
  class Transcoder
    def self.convert
      system(`ffmpeg -framerate 1 \
      -pattern_type glob -i './tmp/imgs/*.jpg' \
      -c:v libx264 -r 10 './tmp/uploads/#{DateTime.now.to_s}.mp4' -loglevel error -stats`)
    end
  end
end