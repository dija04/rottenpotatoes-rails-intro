class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    reirect = true

    @sort = params[:sort] ? params[:sort] : session[:sort]

    @ratings = params[:ratings]? params[:ratings] : session[:ratings]

    @all_ratings = Movie.pluck(:rating).uniq

    if params[:sort] != @sort || params[:ratings] != @ratings
      redirect = true
    end

    if @ratings.nil?
      @ratings = {}
      @all_ratings.each { |i| @ratings[i] = 1 }
    end

    redirect_to movies_path(sort:@sort, ratings:@ratings) if redirect

    @movies = Movie.find(:all, conditions: { rating: @ratings.keys }, order: @sort)

    session[:sort] = @sort
    session[:ratings] = @ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
