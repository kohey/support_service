class PostsController < ApplicationController
  require 'payjp'
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  Payjp.api_key = 'sk_test_4a76108ff8422c150022db51'

  def create
    # binding.pry
  @post = current_user.posts.build(post_params)

  if @post.save
    flash[:success] = '投稿しました'
    redirect_to root_url
  else
    flash[:danger] = '投稿できませんでした'
    render 'toppages/index'
  end
  end

  def destroy
    # binding.pry
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_back(fallback_location: root_path)
  end

  def show
    # binding.pry
    @post = Post.find(params[:id])
    @token = params['payjp-token']
  end

  def pay
    binding.pry
    Payjp::Charge.create(
      :amount => 3500,
      :card => params[:token],
      :currency => 'jpy',
      )
    redirect_to '/'

  end

  private

  #投稿内容,金額は必須とする
  def post_params
    params.require(:post).permit(:content,:amount)
  end

  #投稿の削除の際にユーザ一致の確認
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
