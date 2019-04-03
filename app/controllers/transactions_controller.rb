class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api_key

  def index

    if user_signed_in? && current_user.pay_id.present?
      card_info = Payjp::Customer.retrieve(current_user.pay_id)[:cards][:data][0]
      @card_last4 = card_info[:last4]
      @card_exp_month = card_info[:exp_month]
      @card_exp_year = card_info[:exp_year]
      @product = Product.find(params[:product_id])
    else
      redirect_to user_cards_path(current_user.id)
    end

  end

  private
  def set_api_key
    Payjp.api_key = 'sk_test_cf22f826afb6315d068a24b2'
  end
end
