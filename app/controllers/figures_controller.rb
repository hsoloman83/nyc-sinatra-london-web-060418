class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end


  post '/figures' do
    @figure = Figure.create(params["figure"])

    if !params["title"]["name"].empty?
      @title = Title.find_or_create_by(:name => params["title"]["name"])
      @figure.titles << @title
    end
      @landmark = Landmark.find_or_create_by(:name => params["landmark"]["name"])
      @figure.landmarks << @landmark
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end


  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])

    # if the parameters exist update if not do nothing
    # if you give data do something if
    if !params["title"]["name"].empty?
      @title = Title.find_or_create_by(:name => params["title"]["name"])
      @figure.titles << @title
    end
      @landmark = Landmark.find_or_create_by(:name => params["landmark"]["name"])
      @figure.landmarks << @landmark

      @figure.save

    redirect to "/figures/#{@figure.id}"
  end


end
