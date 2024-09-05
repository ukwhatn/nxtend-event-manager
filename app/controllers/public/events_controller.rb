class Public::EventsController < ApplicationController
  def index
    @user = User.get_user_from_session(session)

    if @user.nil?
      redirect_to root_path
      return
    end

    @events = @user.events

    @title = "出席したイベント一覧"
  end

  def show
  end
end
