#######使わないかも
####################



require 'payjp'

class PostPayment < ApplicationRecord
  belongs_to :posts
  Payjp::api_key = ENV['PAYJP_PRIVATE_KEY']

  #
  # カードトークンを生成する
  #
  def self.create_token(number, cvc, exp_month, exp_year)
    token = Payjp::Token.create(
      card: {
        number:    number,
        cvc:       cvc,
        exp_year:  exp_year,
        exp_month: exp_month,
      }
    )
    return token.id
  end

  #
  # カードトークンを用いて支払いを作成する
  #
  def self.create_charge_by_token(token, amount)
    Payjp::Charge.create(
      amount:   amount,
      card:     token,
      currency: 'jpy'
    )
  end

  #
  # 顧客を登録する
  #
  def self.create_customer(number, cvc, exp_month, exp_year)
    token = self.create_token(number, cvc, exp_month, exp_year)
    Payjp::Customer.create(card: token)
  end

  #
  # 顧客を用いて支払いを作成する
  #
  def self.create_charge_by_customer(customer, amount)
    Payjp::Charge.create(
      amount:   amount,
      customer: customer,
      currency: 'jpy'
    )
  end

end
