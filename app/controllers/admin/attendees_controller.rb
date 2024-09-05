class Admin::AttendeesController < ApplicationController
  before_action :check_admin_logged_in

  def destroy_event_attendance
    event = Event.find_by(public_id: params[:event_public_id])
    if event.nil?
      redirect_to referer, alert: "イベントが見つかりません"
      return
    end

    attendee = event.user_event_attendances.find(params[:id])

    if attendee.nil?
      redirect_to referer, alert: "出席情報が見つかりません"
      return
    end

    attendee.destroy
    redirect_to admin_event_path(event.public_id), notice: "イベントの出席情報を削除しました"
  end

  def destroy_program_attendance
    event = Event.find_by(public_id: params[:event_public_id])
    if event.nil?
      redirect_to referer, alert: "イベントが見つかりません"
      return
    end

    program = event.event_programs.find_by(public_id: params[:program_public_id])
    if program.nil?
      redirect_to referer, alert: "プログラムが見つかりません"
      return
    end

    attendee = program.user_program_attendances.find_by(id: params[:id])

    if attendee.nil?
      redirect_to referer, alert: "出席情報が見つかりません"
      return
    end

    attendee.destroy
    redirect_to admin_program_path(event.public_id, program.public_id), notice: "プログラムの出席情報を削除しました"
  end

  private

  def check_admin_logged_in
    unless session[:admin_logged_in].present? && session[:admin_logged_in]
      redirect_to admin_sign_in_path
    end
  end
end
