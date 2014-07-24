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

  delete '/delete/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/edit/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  get '/all' do
    "#{IdeaStore.all}"
  end

  post '/like/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  post '/dislike/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.dislike!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  get '/tag/:tag' do |tag|
    ideas = IdeaStore.find_by_tag(tag)
    erb :tag, locals: { tag: tag, ideas: ideas }
  end
  
  get '/stats' do
    weekly_stats = IdeaStats.week
    daily_stats = IdeaStats.day
    erb :stats, locals: { daily_stats: daily_stats, weekly_stats: weekly_stats }
  end

  helpers do
    def img(name)
      "<img class='img-responsive img-rounded' src='/images/#{name}' alt='#{name}''/>"
    end
  end
end
