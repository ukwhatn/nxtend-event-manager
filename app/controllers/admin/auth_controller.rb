class Admin::AuthController < ApplicationController
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
end
