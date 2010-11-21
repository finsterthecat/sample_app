class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save then
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = @user.password_confirmation = ""
      render 'new'
    end
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

end
