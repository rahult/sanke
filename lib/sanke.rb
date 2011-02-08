require "sinatra/base"
require "digest/md5"
require "base64"

class Sanke < Sinatra::Base
  get '/' do
    'Welcome to sanka, to be used in conjuction with an iPhone!'
  end

  get '/images' do
    @images = Dir.glob("public/*.jpg")
    erb :index, :views_directory => 'views'
  end

  post '/store' do
    unless params[:data].empty?
      imageData = Base64.decode64(params[:data])
      File.open("public/#{Digest::MD5.hexdigest(params[:data])}.jpg", 'w') { |f| f.write(imageData) }
    end
  end

end
