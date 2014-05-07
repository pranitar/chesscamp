class UsersController < ApplicationController
  before_action :check_login, only: [:new, :edit, :create, :update, :destroy]
  def new
    authorize! :new, @user
    @user = User.new
  end

  def edit
    authorize! :update, @user
    @user = current_user
  end

  def create
    authorize! :new, @user
    params[:user][:instructor_id] ? users = params[:user][:instructor_id] : users = Array.new
    @user = User.new(user_params) if User.check_instructor(instructor)

    if @user.save
      session[:user_id] = @user.id
      redirect_to(@user, :notice => 'User was successfully created.')
    else
      params[:user][:instructor_id] = nil
      render :action => "new"
    end
  end

  def update
    authorize! :update, @user
    @user = current_user
    if @user.update_attributes(current_user)
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private
  def user_params
    if current_user && current_user.role?(:admin)
      params.require(:user).permit(:username, :password, :password_confirmation, :role, :instructor_id)  
    else
      params.require(:user).permit(:username, :password, :password_confirmation, :instructor_id)
    end
  end
end