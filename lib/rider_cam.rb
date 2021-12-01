# frozen_string_literal: true

require 'yaml'
require 'net/http'
require 'google/apis/driveactivity_v2'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'pry-byebug'

class RiderCam

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze # NOTE: specific URI to express out of browser apps
  TOKEN_PATH = File.join(Dir.pwd, 'tmp/token.yaml').freeze # NOTE: store user access and refresh token for use after first time
  SCOPE = Google::Apis::DriveactivityV2::AUTH_DRIVE_ACTIVITY_READONLY

  attr_accessor :config

  def initialize
    @config = YAML.load_file(File.join(Dir.pwd, 'config/drive.yml'))
  end

  def print_files
    session.files.each do |file|
      puts file.title
    end
  end

  def authorize
    client_id = Google::Auth::ClientId.new(@config['client_id'], @config['client_secret'])
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    credentials = authorizer.get_credentials('default')

    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(user_id: 'default', code: code, base_url: OOB_URI)
    end

    credentials
  end
end