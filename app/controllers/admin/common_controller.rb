class Admin::CommonController < ApplicationController
  def top
    if session[:admin_logged_in].present? && session[:admin_logged_in]
      @title = "管理者メニュー"
      render "admin/common/top"
    else
      redirect_to "/admin/sign_in"
    end
  end
end
