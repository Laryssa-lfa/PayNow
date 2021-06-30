class PaymentConfirmationsController < ApplicationController
  before_action :authenticate_admin!, only: %i[index new create]

  def index
    @payment_confirmations = PaymentConfirmation.all
  end

  def new
    @billing_issues = BillingIssue.where(status: :false)
    @payment_confirmation = PaymentConfirmation.new
  end

  def create
    @payment_confirmation = PaymentConfirmation.new(payment_confirmation_params)
    @billing_issue = BillingIssue.find_by(token: @payment_confirmation.billing_token)
    @payment_confirmation.payment_date = Date.today
    @billing_issue.status = true if @payment_confirmation.status_code == "05"
    # @billing_issue.create_with(status: true) if @payment_confirmation.status_code == "05"
    
    @payment_confirmation.save!
    redirect_to new_payment_confirmation_path, notice: "Confirmação realizada"
  end

  private

  def payment_confirmation_params
    params.require(:payment_confirmation)
          .permit(:status_code, :payment_date, :billing_token, :token)
  end
end
