require "rubygems" if RUBY_VERSION < "1.9"
require "sinatra/base"
require "base64"
require "digest/md5"

class KoiStore < Sinatra::Base
  get '/' do
    'Hello World from KoiStore!'
  end

  post '/store' do
    unless params[:data].empty?
      imageData = Base64.decode64(params[:data])
      File.open("uploads/#{Digest::MD5.hexdigest(params[:data])}.jpg", 'w') { |f| f.write(imageData) }
    end
  end

end
