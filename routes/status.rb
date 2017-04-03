require 'sinatra/base'
require 'json'

module MPDWeb
  module Routes
    class Status < Base
      get '/status/' do
        headers 'Access-Control-Allow-Origin' => '*'
        body @mpd.status.to_json
      end

      put "/status/" do
        # TODO - this needs some kind of layer where validation
        # can go.  also to be logically separated somehow, we can't
        # just manually check each field in this one method.
        incoming = JSON.parse(request.body.read, {:symbolize_names => true})

        if incoming[:song].to_i != @mpd.status[:song]
          @mpd.play(incoming[:song].to_i)
        end

        if %w[play stop].include?(incoming[:state])
          @mpd.send(incoming[:state])
        end

        if incoming[:state] == 'pause'
          @mpd.pause = true
        end

        @mpd.status.to_json
      end
    end
  end
end
