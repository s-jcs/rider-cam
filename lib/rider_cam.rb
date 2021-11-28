# frozen_string_literal: true

require 'yaml'
require 'net/http'

class RiderCam

  attr_accessor :config

  def initialize
    @config = YAML.load_file('./config/drive.yml')
  end

  def print_files
    session.files.each do |file|
      puts file.title
    end
  end
end
