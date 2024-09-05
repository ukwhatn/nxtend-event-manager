class Public::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create_token_for_discord

  def create_token_for_discord
    discord_id = params[:discord_id]
    if discord_id.blank?
      render json: { error: "Discord ID is required" }, status: :bad_request
      return
    end

    token_data = UserLoginToken.create_with_token(discord_id.to_i)

    url = auth_discord_url + "?token=" + token_data.token

    render json: { url: url, token: token_data.token }, status: :created
  end

  def sign_in_with_discord
    token = params[:token]
    if token.blank?
      render json: { error: "Token is required" }, status: :bad_request
      return
    end

    token_data = UserLoginToken.find_by_token(token)
    if token_data.nil?
      render json: { error: "Invalid token" }, status: :not_found
      return
    end

    if token_data.is_used
      render json: { error: "Token has already been used" }, status: :bad_request
      return
    end

    if token_data.is_expired
      render json: { error: "Token has expired" }, status: :bad_request
      return
    end

    token_data.mark_used

    user = token_data.find_user

    if user.nil?
      session[:discord_id] = token_data.discord_id
      redirect_to sign_up_path
      return
    end

    session[:user_id] = user.id
    redirect_to root_path
  end
end
