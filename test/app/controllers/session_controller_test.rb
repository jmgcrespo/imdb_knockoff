require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

def session
  last_request.env['rack.session']
end

describe 'POST /session' do
  describe 'with valid credentials' do
    it 'creates a new session' do
      post '/session', username: 'username', password: 'password'
      assert session[:authenticated]
    end
    it 'redirects to the new movie action' do
      post '/session', username: 'username', password: 'password'
      assert last_response.redirect?, 'It didn´t redirect'
    end
  end

  describe 'with invalid credentials' do
    it 'redirects to the homepage' do
      post '/session', username: 'bad', password: 'bad'

      assert last_response.status == 403, 'Not a 403'
    end
  end
end
