class Admin::EventsController < ApplicationController
  def index
    @new_event = Event.new
    @all_events = Event.all

    @title = "管理：イベント一覧"
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
    @all_programs = @event.event_programs
    @new_program = EventProgram.new
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end
end
