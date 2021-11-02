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
  replace_words = ['Amazon','Deloitte','Google','Microsoft','Oracle']
  replace_words.push(replace_words.map{|x| x.downcase }).flatten!
  replace_words.each do |word|
    if input[word]
      input.gsub!(word, "#{word.capitalize}©")
    end
  end
  replace_phrases = {'Google' => ['Cloud']}
  replace_phrases.each do | base_word, children |
    children.each do | child_word |
      if input["#{base_word}© #{child_word}"]
        input.gsub!("#{base_word}© #{child_word}", "#{base_word} #{child_word}©")
      end
    end
  end
  input
end
