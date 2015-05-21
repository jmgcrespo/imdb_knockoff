require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')


describe "GET /movies" do
	before do

    @movies = [ Movie.create!(name: 'Jaws', rating: 5) ]
  	@movies << Movie.create!(name: 'Superman', rating: 4)
  	@movies << Movie.create!(name: 'Star Treck', rating: 5)
  	get '/movies'
  end

	it "responds OK" do
		assert last_response.ok?
	end

	it "list all movies" do
		@movies.each do |movie|
		assert_includes last_response.body, movie.name
		end
	end

	
end



describe "GET /movies/new" do
  it "responds OK" do
    get "/movies/new"

    assert last_response.ok?
  end
end

describe "GET /movies/:id" do
  before do
    @movie = Movie.create!(name: 'Jaws', rating: 5)
    get "/movies/#{@movie.id}"
  end

  it "displays the name" do
    assert_includes last_response.body, @movie.name
  end

  it "displays the rating" do
    assert_includes last_response.body, @movie.rating.to_s
  end
end

describe "POST /movies" do
  before do
    post "/movies", { name: "Jaws", rating: 5 }
  end

  it "creates a movie" do
    jaws = Movie.first

    assert_equal jaws.name, "Jaws"
    assert_equal jaws.rating, 5
  end

  it "redirects to our new movie" do
    assert last_response.redirect?
  end
end
