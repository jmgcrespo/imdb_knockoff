ImdbKnockoff::App.controllers :home do
  get :index, map: '/' do
    @username = session[:username]
    render 'index'
  end

  get :username, map: '/username' do
    session[:username] = Time.now

    redirect to('/')
  end
end
