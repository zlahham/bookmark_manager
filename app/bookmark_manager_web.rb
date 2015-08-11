require 'sinatra/base'
require_relative '../data_mapper_setup'

class BookMarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all # => looks at all entries within links class in DB
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tag = Tag.create(name: params[:tag])
    link.tags << tag
    link.save
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/form'
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
  set :views, proc { File.join(root, '..', 'views') }
end
