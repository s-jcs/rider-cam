# frozen_string_literal: true

require 'date'
require 'streamio-ffmpeg'

module RiderCam
  class Compressor
    def transcode(dir = './tmp/imgs')
      transcoder = FFMPEG::Transcoder.new(
        '',
        "#{DateTime.now.to_s}.mp4",
        { resolution: '640x480' },
        input: "#{dir}/img_1.jpg",
        input_options: { framerate: '1/10' }
      )
      file = transcoder.run
    end
  end
end