class Api::V1::BillingIssuesController < Api::V1::ApiController

  def index
    render json: '', status: :not_found
  end

  def show
    @billing_issue = BillingIssue.find_by!(token: params[:token])
    @billing_issue.product_attributes
    render json: @billing_issue
  end

  def create
    @billing_issue = BillingIssue.new(billing_issue_params)
    @billing_issue.product_attributes
    @billing_issue.save!
    render json: @billing_issue, status: :created
  end

  private

  def billing_issue_params
    params.require(:billing_issue)
          .permit(:company_token, :product_token, :end_client_token,
                  :type_payment, :card_number, :name_client_card,
                  :verification_code, :full_address, :price_product,
                  :price_discount, :status, :token)
  end
end
