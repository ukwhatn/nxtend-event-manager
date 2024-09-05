class Admin::AttendeesController < ApplicationController
  before_action :check_admin_logged_in

  private

  def check_admin_logged_in
    unless session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_sign_in_path
    end
  end
end
