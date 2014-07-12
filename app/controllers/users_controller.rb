class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
  	@user = User.new
  end

  def index
    @users = User.paginate(page: params[:page]) #@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
		if @user.save
      sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
  end

  def edit
    #@user = User.find(params[:id]) #this line is defined in correct_user
  end

  def update
    #@user = User.find(params[:id]) #this line is defined in correct_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end


  private

    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user #construction ':notice' doesn’t work for the :error or :success keys.
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please Sign in."
                        #flash[:notice] = "Please sign in."
      end
    end

    def logged_in_user
      if signed_in?
        button?('show sign_out button')
        redirect_to root_url, notice: "Please Sign out, if you want to create a new account."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
