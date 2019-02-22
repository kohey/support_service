class ToppagesController < ApplicationController
  def index
    #ログインしてたらトップページに一部表示させる
    if logged_in?
      @post = current_user.posts.build
      @posts = Post.all
    end
  end

  #決済機能
  def donate
    Payjp.api_key = PAYJP_SECRET_KEY
    Payjp::Charge.create(currency: 'jpy', amount: 1000, card: params['payjp-token'])
    redirect_to root_path, notice: "支払いが完了しました"
  end
end
