class UsersController < ApplicationController
  
  before_filter :find_user, :only => [:edit, :update, :destroy]
  before_filter :can_edit_user, :only => [:edit, :update_destroy]
  
  def index
    @users = User.find(:all, :order => 'last_login_at desc')
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Your account has been created"
      do_login(@user)
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.profile_updated_at = Time.now.utc
    @user.update_attributes(params[:user])
    redirect_to user_path(@user)
  end
  
  def login
    redirect_to home_path if logged_in?
    if request.post?
      @user = User.authenticate(params[:user][:login], params[:user][:password]) 
      if @user
        do_login(@user)
      else
        flash[:notice] = "Invalid user/password combination"
        render :action => :login
      end
    end
  end
  
  def logout
    reset_online_at
    reset_session
    redirect_to home_path
  end
    
  protected
    
  def find_user
    @user = params[:id] ? User.find_by_id(params[:id]) : current_user
  end
  
  def can_edit_user
    @user = Topic.find(params[:id])
    redirect_to user_path(@user) and return false unless admin? || (current_user == @user)
  end
  
  def do_login(user)
    session[:user_id] = user.id
    session[:last_login_at] = user.last_login_at
    user.last_login_at = Time.now.utc
    user.save!
    redirect_to home_path
  end
  
end
