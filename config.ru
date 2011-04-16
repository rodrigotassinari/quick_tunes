require './quick_tunes'

require 'rack/reloader'
use Rack::Reloader, 0 if development?

## There is no need to set directories here anymore;
## Just run the application
run Sinatra::Application
