To run locally:

Requiements:
 - Ruby >=2.7
 - bundler

Install:
  bundle install

Alternative install:
  bundle install --path vendor/bundle
  export GEM_PATH=$(pwd)/replacer/ruby/vendor/bundle/ruby/2.7.0/

To Run:
  bundle exec passenger start
  runs on localhost:3000
Or via Sinatra:
  ruby app.rb
  runs on localhost:4567
Passenger is recommended for easier restart via `touch tmp/restart.txt`
