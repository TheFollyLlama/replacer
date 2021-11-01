require 'sinatra'
require 'json'

def default
  File.read('ascii.html')
end

get '/' do
  default
end

get '/replace/:input' do |input|
  replacer(input)
end

post '/replace' do
  payload = JSON.parse request.body.read
  replacer(payload["input"])
end

def replacer(input)
  replace_words = ['Amazon','Deloitte','Google','Google Cloud','Microsoft','Oracle']
  replace_words.push(replace_words.map{|x| x.downcase }).flatten!
  for word in replace_words
    if input[word]
      input[word] = "#{word}©"
    end
  end
  input
end
