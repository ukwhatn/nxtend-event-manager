class Public::AttendancesController < ApplicationController
  before_action :check_logged_in

  def create

    token = params[:token]

    event = Event.find_by(attendance_token: token)
    program = EventProgram.find_by(attendance_token: token)

    if event.nil? && program.nil?
      redirect_to root_path, alert: "イベントまたはプログラムが見つかりません"
      return
    end

    if event.present?
      attendance = @user.user_event_attendances.new(event_id: event.id)
    else
      event = program.event

      # ユーザがイベントに参加していない場合はエラー
      unless @user.events.include?(event)
        redirect_to root_path, alert: "イベントに出席登録していません、スタッフにお声がけください"
        return
      end

      attendance = @user.user_program_attendances.new(event_program_id: program.id)
    end

    if attendance.save
      redirect_to root_path, notice: "出席を記録しました"
    else
      redirect_to root_path, alert: "出席の記録に失敗しました、再度お試しください"
    end

  end

  private

  def check_logged_in
    @user = User.get_user_from_session(session)
    unless @user.present?
      redirect_to root_path
    end
  end
end
