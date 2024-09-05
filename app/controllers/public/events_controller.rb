class Public::EventsController < ApplicationController
  before_action :check_logged_in

  def index
    # @events = @user.events
    # @title = "出席したイベント一覧"
  end

  def show
  end

  private

  def check_logged_in
    @user = User.get_user_from_session(session)
    if @user.nil?
      redirect_to root_path
    end
  end
end
