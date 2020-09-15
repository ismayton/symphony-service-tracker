require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "projectsecret"
  end

  get '/' do 
    @musicians = Musician.all
    @sections = Section.all
    erb :index
  end 

  get '/signup' do
    erb :signup 
  end 

  post '/signup' do 
    if User.find_by(email: params[:email])
      redirect to '/login'
    end 
    if params[:admin] == Admin.admin_password 
      @admin = Admin.create(email: params[:email], password: params[:password])
      session[:admin_id] = @admin.id
      redirect to '/'
    elsif params[:email] && params[:password]
      @user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/'
    else
      redirect to '/signup'
    end

  end 

  get '/login' do 
    if !logged_in?
      erb :login 
    else 
      redirect to '/'
    end 
  end 

  post '/login' do 
    if Admin.find_by(email: params[:email])
      @admin = Admin.find_by(email: params[:email])
      if @admin && @admin.authenticate(params[:password])
        session[:admin_id] = @admin.id
        redirect to '/'
      else
        redirect '/login'
      end

    else 
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/'
      else
        redirect '/login'
      end
    end
  end 

  get '/logout' do 
    if session[:admin_id] || session[:user_id]
      session.clear
    end
    redirect to '/'
  end 

  helpers do
    def admin?
      session[:admin_id]
    end

    def logged_in?
      session[:user_id] || session[:admin_id]
    end 

  end
end
