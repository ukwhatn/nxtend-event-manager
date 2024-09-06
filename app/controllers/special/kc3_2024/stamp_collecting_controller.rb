class Special::Kc32024::StampCollectingController < ApplicationController
  before_action :check_logged_in, only: [:index, :get]
  before_action :check_admin_logged_in, only: [:admin, :admin_create, :admin_destroy, :admin_update]

  def index
    @user_stamps = @user.kc32024_stamps
    @user_required_stamps = @user_stamps.where(is_required: true)
    @user_non_required_stamps = @user_stamps.where(is_required: false)

    @user_required_stamps_count = @user_required_stamps.count
    @user_stamps_count = @user_stamps.count + @user_required_stamps_count

    @all_stamps = Kc32024Stamp.all
    @all_required_stamps = Kc32024Stamp.where(is_required: true)
    @all_non_required_stamps = Kc32024Stamp.where(is_required: false)

    @all_required_stamps_count = Kc32024Stamp.where(is_required: true).count
    @all_stamps_count = Kc32024Stamp.count + @all_required_stamps_count

    @unregistered_required_stamps = @all_required_stamps - @user_required_stamps
    @unregistered_non_required_stamps = @all_non_required_stamps - @user_non_required_stamps

    @threshold = ENV["KC32024_STAMP_THRESHOLD"].to_i

    @is_completed = @user_stamps_count >= @threshold

    if @is_completed
      @lottery_number = Kc32024LotteryNumber.find_by(user_id: @user.id)

      unless @lottery_number.present?
        num = Kc32024LotteryNumber.create_lottery_number
        @lottery_number = Kc32024LotteryNumber.create(user_id: @user.id, number: num)
      end
    end

    render "special/kc3_2024/stamp_collecting/index"
  end

  def get
    token = params[:token]
    stamp = Kc32024Stamp.find_by(collection_token: token)
    if stamp.present?
      user_stamp = Kc32024StampCollect.find_by(user_id: @user.id, kc32024_stamp_id: stamp.id)
      unless user_stamp.present?
        Kc32024StampCollect.create(user_id: @user.id, kc32024_stamp_id: stamp.id)
        redirect_to special_kc3_2024_stamp_collecting_path, notice: "スタンプを取得しました"
      else
        redirect_to special_kc3_2024_stamp_collecting_path, alert: "スタンプはすでに取得済みです"
      end
    else
      redirect_to special_kc3_2024_stamp_collecting_path, alert: "スタンプが見つかりません"
    end
  end

  def admin
    @new_stamp = Kc32024Stamp.new
    @stamps = Kc32024Stamp.all.sort_by { |stamp| stamp.created_at }

    @lottery_numbers = Kc32024LotteryNumber.all

    render "special/kc3_2024/stamp_collecting/admin"
  end

  def admin_create
    @new_stamp = Kc32024Stamp.new(stamp_collecting_params)
    token = nil
    loop do
      token = SecureRandom.hex(16)
      break unless Kc32024Stamp.exists?(collection_token: token)
    end
    @new_stamp.collection_token = token
    if @new_stamp.save
      redirect_to special_kc3_2024_stamp_collecting_admin_path, notice: "スタンプを作成しました"
    else
      @stamps = Kc32024Stamp.all
      @lottery_numbers = Kc32024LotteryNumber.all
      redirect_to special_kc3_2024_stamp_collecting_admin_path, alert: "スタンプの作成に失敗しました"
    end
  end

  def admin_destroy
    target = Kc32024Stamp.find(params[:id])
    target.destroy
    redirect_to special_kc3_2024_stamp_collecting_admin_path, notice: "スタンプを削除しました"
  end

  def admin_update
    target = Kc32024Stamp.find(params[:id])
    if target.update(stamp_collecting_params)
      redirect_to special_kc3_2024_stamp_collecting_admin_path, notice: "スタンプを更新しました"
    else
      redirect_to special_kc3_2024_stamp_collecting_admin_path, alert: "スタンプの更新に失敗しました"
    end
  end
end

private

def check_logged_in
  @user = User.get_user_from_session(session)
  unless @user.present?
    redirect_to root_path
  end
end

def check_admin_logged_in
  unless session[:admin_logged_in].present? && session[:admin_logged_in]
    redirect_to admin_sign_in_path
  end
end

def stamp_collecting_params
  params.require(:kc32024_stamp).permit(:name, :is_required)
end

