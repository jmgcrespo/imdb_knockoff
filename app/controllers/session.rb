ImdbKnockoff::App.controllers :session do
  
  post :create, map: '/session' do

  	if params[:username] == "username" && params[:password] == 'password'
  	 session[:authenticated] = true
  	 redirect url(:movies,:new)
  else
  		halt 403, "NOT AUTHORIZED"
  	end
  end

  get :new do
   render :new
  end
  

end
