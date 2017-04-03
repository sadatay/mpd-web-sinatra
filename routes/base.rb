require 'sinatra/base'
require 'ruby-mpd'
require 'pry-remote'

module MPDWeb
  module Routes
    class Base < Sinatra::Base
      get '/' do
        'Hello world!'
      end

      options '*' do
        if request.request_method == 'OPTIONS'
          response.headers["Access-Control-Allow-Origin"] = "*"
          response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT"
          response.headers["Access-Control-Allow-Headers"] = "Content-Type"
          halt 200
        end
      end

      before do
        content_type :json
        begin
          @mpd = MPD.new('localhost', 6600)
          @mpd.connect
        rescue Errno::ECONNREFUSED, EOFError
          halt 403, "Connection to MPD server refused."
        end
        headers 'Access-Control-Allow-Origin' => '*'
      end

      after do
        @mpd.disconnect
      end
    end
  end
end
