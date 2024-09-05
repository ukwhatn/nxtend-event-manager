class Public::AttendancesController < ApplicationController
  before_action :check_logged_in

  include ActionView::Helpers::DateHelper

  def create

    token = params[:token]

    event = Event.find_by(attendance_token: token)
    program = EventProgram.find_by(attendance_token: token)

    if event.nil? && program.nil?
      redirect_to root_path, alert: "イベントまたはプログラムが見つかりません"
      return
    end

    if event.present?
      event_name = "イベント：#{event.name}"
      # 存在チェック
      if @user.events.include?(event)
        render template: "public/attendances/error", locals: {
          message: "既に登録されています",
          description1: event_name,
          description2: "登録日時：#{time_ago_in_words(@user.user_event_attendances.find_by(event_id: event.id).created_at)}前"
        }
        return
      end

      attendance = @user.user_event_attendances.new(event_id: event.id)
    else
      event = program.event

      # ユーザがイベントに参加していない場合はエラー
      unless @user.events.include?(event)
        render template: "public/attendances/error", locals: {
          message: "イベントに参加していません",
          description1: "スタッフにお声がけください",
          description2: "イベント：#{event.name}"
        }
        return
      end

      event_name = "イベント：[#{event.name}] #{program.name}"

      # 存在チェック
      if @user.event_programs.include?(program)
        render template: "public/attendances/error", locals: {
          message: "既に登録されています",
          description1: event_name,
          description2: "登録日時：#{time_ago_in_words(@user.user_program_attendances.find_by(event_program_id: program.id).created_at)}前"
        }
        return
      end

      attendance = @user.user_program_attendances.new(event_program_id: program.id)
    end

    if attendance.save
      render template: "public/attendances/first", locals: {
        description1: event_name,
        description2: "スタッフへの提示が必要な場合がありますので、画面はそのままにしてください"
      }
    else
      render template: "public/attendances/error", locals: {
        message: "出席登録時にエラーが発生しました",
        description1: event_name,
        description2: "スタッフにお声がけください"
      }
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
