class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #全ての状態でログイン判定が可能
  include SessionsHelper


  private
  #全ての状態でログインしている事が必要
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
