RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/helpers/**/*.rb')]
  .each(&method(:require))

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  include Rack::Test::Methods

  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end

  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end
end
