require 'sinatra'
require 'require_all'
require 'sinatra/cross_origin'
require_rel 'routes'

module MPDWeb
  class App < Sinatra::Application
    set :bind, '0.0.0.0'

    # use route modules here
    use MPDWeb::Routes::Base
    use MPDWeb::Routes::Queue
    use MPDWeb::Routes::Status

    run! if app_file == $0

    not_found do
      halt 404, "Route not found"
    end
  end
end
