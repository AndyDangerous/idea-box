require 'bundler'
require 'haml'
require 'idea_box'
Bundler.require

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  set :public_folder, 'public'

  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new}
  end

  post '/' do
    IdeaBuilder.build(params[:idea])

    redirect '/'
  end

  get '/ip' do
    ip_address = request.ip
    "Your IP Address: #{ip_address}"
    "Your Address is: #{ip_address.}"
    "Your coordinates are: #{ip_address.}"
  end

  delete '/:i/delete' do |i|
    IdeaStore.delete(i.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  get '/:tag' do |tag|
    ideas = IdeaStore.find_by_tag(tag)
    erb :tag, locals: { tag: tag, ideas: ideas }
  end

  helpers do
    def img(name)
      "<img src='/images/#{name}' alt='#{name}' />"
    end
  end
end
