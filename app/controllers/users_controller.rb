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
    params[:user] = normalize_params(params[:user])

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

  def normalize_params(user_params)
    if has_admin_params?(user_params)
      user_params[:is_admin] = user_params[:is_admin] == "1"
    end

    user_params
  end

  def has_admin_params?(user_params)
    user_params.present? && user_params[:is_admin].present?
  end
end
