class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => 'User was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy

    redirect_to users_url
  end

  private 

  def not_allowed?
    current_user.present? == false || current_user.is_admin? == false
  end
end
