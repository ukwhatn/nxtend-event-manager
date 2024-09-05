class Admin::ProgramsController < ApplicationController
  before_action :check_admin_logged_in

  def create
    @event = Event.find_by(public_id: params[:event_public_id])
    @new_program = @event.event_programs.new(program_params)

    # attendance_tokenとpublic_idを重複しないように生成
    loop do
      @new_program.attendance_token = SecureRandom.hex(16)
      @new_program.public_id = SecureRandom.hex(4)
      break if @new_program.check_public_id_duplication && @new_program.check_attendance_token_duplication
    end

    if @new_program.save
      redirect_to admin_event_path(@event.public_id), notice: "プログラムを作成しました"
    else
      redirect_to admin_event_path(@event.public_id), alert: "プログラムの作成に失敗しました"
    end
  end

  def show
    @event = Event.find_by(public_id: params[:event_public_id])
    @program = EventProgram.find_by(public_id: params[:public_id])

    if @event.nil? || @program.nil?
      redirect_to admin_events_path, alert: "イベントまたはプログラムが見つかりません"
      return
    end

    @title = "管理：プログラム詳細：#{@program.name}"
    @all_attendances = @program.user_program_attendances
  end

  def destroy
    @event = Event.find_by(public_id: params[:event_public_id])
    @program = EventProgram.find_by(public_id: params[:public_id])

    if @event.nil? || @program.nil?
      redirect_to admin_events_path, alert: "イベントまたはプログラムが見つかりません"
      return
    end

    @program.destroy
    redirect_to admin_event_path(@event.public_id), notice: "プログラムを削除しました"
  end

  private

  def program_params
    params.require(:event_program).permit(:name)
  end

  def check_admin_logged_in
    unless session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_sign_in_path
    end
  end
end
