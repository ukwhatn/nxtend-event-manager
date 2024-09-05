class Admin::UsersController < ApplicationController
  before_action :check_admin_logged_in

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end

  def logged_in_as_user
    user = User.find(params[:id])
    session[:user_id] = user.id
    redirect_to root_path
  end

  private

  def check_admin_logged_in
    unless session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_sign_in_path
    end
  end
end
