module SessionsHelper

  #ユーザの特定
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #ログインしているか
  def logged_in?
    if current_user
      return true
    else
      return false
    end
  end
end
