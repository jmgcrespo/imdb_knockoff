require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe Movie do

  it "can construct a new instance" do
    movie = Movie.new
    refute_nil movie
  end
  
  describe "validation" do
    it "is valida with valid attributes" do
      assert Movie.new(name: "Jaws").valid?
    end

    it "requires a name" do 
      assert Movie.new(rating: 5).invalid?
    end

    it "rating must 1..5" do

      assert Movie.new( name: "ET", rating: 6).invalid?, "Rated 6 and still valid"
      assert Movie.new( name: "ET", rating: -1).invalid?, "Rated -1 and still valid "
    end
  end

  
end
