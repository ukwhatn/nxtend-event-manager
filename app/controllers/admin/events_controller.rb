class Admin::EventsController < ApplicationController
  before_action :check_admin_logged_in

  def index
    @new_event = Event.new
    @all_events = Event.all

    @title = "管理：イベント一覧"
    @back_link = admin_path
  end

  def create
    @new_event = Event.new(event_params)

    # attendance_tokenとpublic_idを重複しないように生成
    loop do
      @new_event.attendance_token = SecureRandom.hex(16)
      @new_event.public_id = SecureRandom.hex(4)
      break if @new_event.check_public_id_duplication && @new_event.check_attendance_token_duplication
    end

    if @new_event.save
      redirect_to admin_event_path(@new_event.public_id)
    else
      @all_events = Event.all
      @title = "管理：イベント一覧"
      render :index
    end
  end

  def show
    @event = Event.find_by(public_id: params[:public_id])

    if @event.nil?
      redirect_to admin_events_path, alert: "イベントが見つかりません"
      return
    end

    @title = "管理：イベント詳細：#{@event.name}"
    @back_link = admin_events_path
    @all_programs = @event.event_programs
    @new_program = EventProgram.new
  end

  def update
    @event = Event.find_by(public_id: params[:public_id])
    @event.update(event_params)
    redirect_to admin_event_path(@event.public_id)
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end

  def check_admin_logged_in
    unless session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_sign_in_path
    end
  end
end
