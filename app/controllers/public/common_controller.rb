class Public::CommonController < ApplicationController
  def top
    if User.get_user_from_session(session).present?
      redirect_to dashboard_path
    end
  end

  def unauthorized
  end

  def not_found
  end
end
