class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #new form
  get '/recipes/new' do
    erb :new
  end

  #new
  post '/recipes/new' do
    recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    recipe.save
    redirect to "/recipes/#{recipe.id}"
  end

  #show
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  #edit form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
  
  #edit
  patch '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{recipe.id}"
  end

  #delete
  delete '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.delete
    redirect to '/recipes'
  end
end
