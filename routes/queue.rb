require 'sinatra/base'
require 'json'

module MPDWeb
  module Routes
    class Queue < Base
      get '/queue/' do
        # return the play queue as json
        @mpd.queue.map { |song| song.to_h }.to_json
      end
    end
  end
end
