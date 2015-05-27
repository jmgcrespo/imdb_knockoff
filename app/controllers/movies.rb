ImdbKnockoff::App.controllers :movies do
  before :new, :create, :update, :delete do
    redirect url(:session, :new) unless session[:authenticated]
  end

  get :new do
    @movie = Movie.new
    render :new
  end

  post :create, map: '/movies' do
    @movie = Movie.create(params[:movie])

    if @movie.valid?
      redirect url(:movies, :show, id: @movie.id)
    else
      render :new
    end
  end

  get :edit, map: 'movies/:id/edit/' do
    @movie = Movie.find(params[:id])
    render :edit
  end

  get :show, map: '/movies/:id' do
    @movie = Movie.find(params[:id])
    render :show
  end

  get :index do
    @movies = Movie.all
    render :index
  end

  put :update, map: '/movies/:id' do
    @movie = Movie.find(params[:id])
    @movie.update(params[:movie])

    redirect url(:movies, :show, id: @movie.id)
  end

  delete :delete, map: 'movies/:id' do
    @movie = Movie.find(params[:id])
    @movie.delete

    redirect url(:movies, :index)
  end
end
