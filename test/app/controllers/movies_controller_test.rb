require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')
describe 'GET /movies' do
  before do
    @movies = [Movie.create!(name: 'Jaws', rating: 5)]
    @movies << Movie.create!(name: 'Superman', rating: 4)
    @movies << Movie.create!(name: 'Star Treck', rating: 5)

    get '/movies'
  end

  it 'responds OK' do
    assert last_response.ok?
  end

  it 'list all movies' do
    @movies.each do |movie|
      assert_includes last_response.body, movie.name
    end
  end
end

describe 'GET /movies/new' do
  describe 'with invalid creadentials' do
    it 'redirects to the login page' do
      get '/movies/new'
      assert_includes last_response.location, 'session/new'
    end
  end
end

describe 'GET /movies/:id' do
  before do
    @movie = Movie.create!(name: 'Jaws', rating: 5)
    get "/movies/#{@movie.id}"
  end

  it 'displays the name' do
    assert_includes last_response.body, @movie.name
  end

  it 'displays the rating' do
    assert_includes last_response.body, @movie.rating.to_s
  end
end

describe 'POST /movies' do
  before do
    env 'rack.session', authenticated: true
    post '/movies', movie: { name: 'Jaws', rating: 5 }
  end

  it 'creates a movie' do
    jaws = Movie.first

    assert_equal 'Jaws', jaws.name
    assert_equal 5, jaws.rating
  end

  it 'redirects to our new movie' do
    assert last_response.redirect?
  end
end
describe 'UPDATE /movies/:id' do
  before do
    @movie = Movie.create!(name: 'Jaws', rating: 5)
    env 'rack.session', authenticated: true
  end

  it 'updated a movie' do
    put "/movies/#{@movie.id}", movie: { id: @movie.id, name: 'ET',
                                         rating: @movie.rating }
    jaws = Movie.first
    assert_equal 'ET', jaws.name
    assert_equal 5, jaws.rating
  end

  it 'can edit a line' do
    get "movies/#{@movie.id}/edit"

    assert_match(/Jaws/, last_response.body)
    assert_match(/5/, last_response.body)
    assert_match(/submit/, last_response.body)
  end
end

describe 'Delete' do
  it 'deletes a movie if you want to' do
    @movie = Movie.create!(name: 'Jaws', rating: 5)
    env 'rack.session', authenticated: true

    delete "movies/#{@movie.id}"
    assert_equal 0, Movie.count
  end
end
