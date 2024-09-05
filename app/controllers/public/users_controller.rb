class Public::UsersController < ApplicationController
  before_action :check_discord_id_in_session, only: [:new, :confirm, :create]
  before_action :check_user_in_session, only: [:new, :confirm, :create]
  before_action :check_discord_id_in_user, only: [:new, :confirm, :create]
  before_action :temp_dict_initializer, only: [:new, :confirm, :create]

  def new
    @title = "ユーザ新規登録"
    @user = User.new

    if session[:temp].present? && session[:temp][:user_register_data].present?
      @user.attributes = session[:temp][:user_register_data]
    end
  end

  def confirm
    @user = User.new(user_params)
    @user.discord_id = session[:discord_id]

    if @user.valid?
      @title = "ユーザ新規登録"
      session[:temp][:user_register_data] = @user.attributes
      render :confirm
    else
      @title = "ユーザ新規登録"
      render :new
    end
  end

  def create
    @user = User.new(session[:temp][:user_register_data])
    @user.discord_id = session[:discord_id]

    if @user.save!
      session[:user_id] = @user.id
      session[:temp][:user_register_data] = nil
      session[:discord_id] = nil
      redirect_to root_path
    else
      redirect_to sign_up_path, danger: "ユーザ登録に失敗しました"
    end
  end

  def redirect_to_sign_up
    redirect_to sign_up_path
  end

  def sign_out
    session[:user_id] = nil
    redirect_to root_path, success: "ログアウトしました"
  end

  private

  def user_params
    params.require(:user).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana, :email
    )
  end

  def check_discord_id_in_session
    if session[:discord_id].blank?
      redirect_to root_path
    end
  end

  def check_user_in_session
    if User.get_user_from_session(session).present?
      redirect_to dashboard_path
    end
  end

  def check_discord_id_in_user
    if User.find_by_discord_id(session[:discord_id]).present?
      redirect_to root_path
    end
  end

  def temp_dict_initializer
    if session[:temp].nil?
      session[:temp] = {}
    end
  end
end
