class Admin::AuthController < ApplicationController
  before_action :check_admin_logged_in, only: [:destroy]
  before_action :check_admin_logged_out, only: [:new, :create]

  def new
  end

  def create
    if params[:user] == ENV["ADMIN_USER"] && params[:password] == ENV["ADMIN_PASSWORD"]
      session[:admin_logged_in] = true
      redirect_to admin_path
    else
      redirect_to admin_sign_in_path, alert: "ユーザー名またはパスワードが違います"
    end
  end

  def destroy
    session[:admin_logged_in] = false
    redirect_to admin_path
  end

  private

  def check_admin_logged_in
    unless session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_sign_in_path
    end
  end

  def check_admin_logged_out
    if session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_path
    end
  end
end
