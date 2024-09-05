class Public::CommonController < ApplicationController
  before_action :set_hide_header

  def top
    if User.get_user_from_session(session).present?
      redirect_to dashboard_path
      return
    end

    if session[:discord_id].present?
      redirect_to sign_up_path
      return
    end
  end

  def unauthorized
  end

  def not_found
  end

  private

  def set_hide_header
    @hide_header = true
  end
end
