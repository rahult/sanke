require "rubygems"
require "sinatra/base"
require "digest/md5"
require "aws/s3"
require "base64"

class Sanke < Sinatra::Base
  get '/' do
    'Welcome to sanka, to be used in conjuction with an iPhone!'
  end

  get '/images' do
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['s3_key'],
      :secret_access_key => ENV['s3_secret'])
    @images = AWS::S3::Bucket.find("sanke.heroku.com").objects
    erb :index, :views_directory => 'views'
  end

  post '/store' do
    unless params[:data].empty?
      imageData = Base64.decode64(params[:data])
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['s3_key'],
        :secret_access_key => ENV['s3_secret'])
      AWS::S3::S3Object.store("#{Digest::MD5.hexdigest(params[:data] + Date.today.to_s)}.jpg", imageData, "sanke.heroku.com", :access => :public_read)
    end
  end

end
