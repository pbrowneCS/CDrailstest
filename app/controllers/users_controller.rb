class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
    
  def show
    @user = User.find(params[:id])
    # @secrets = Secret.all
  end

  def new
  end

  def index
    if session[:user_id]
      redirect_to current_user
    else
      redirect_to '/sessions/new'
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to user_path(session[:user_id])
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # if @user.update(user_params)
      User.where(id: params[:id]).limit(1).update_all(user_params)
      flash[:success] = "User successfully updated"
      redirect_to user_path(session[:user_id])
    # else
      # flash[:errors] = @user.errors.full_messages
      # redirect_to :back
    # end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'   
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end