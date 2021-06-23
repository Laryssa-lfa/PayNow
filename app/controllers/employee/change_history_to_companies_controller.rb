class Employee::ChangeHistoryToCompaniesController < ApplicationController
  before_action :authenticate_admin!, only: %i[index show]
  before_action :set_change, only: %i[show edit update]

  def index
    @change_history_to_companies = ChangeHistoryToCompany.all
  end

  def show
  end

  def new
    byebug
    @change_history_to_company = ChangeHistoryToCompany.new
  end

  def create
    @change_history_to_company.create!(change_params)
  end

  def edit
  end

  def update
  end

  private

  def change_params
    params.require(:change_history_to_company).permit(:cnpj, :corporate_name, :address, :email,
                                                      :token, :client_id, :status, :company_id)
  end

#  def change_params
#    params(cnpj: @company.cnpj, corporate_name: @company.corporate_name, address: @company.address,
#           email: @company.email, token: @company.token, status: @company.view_status,
#           client_id: @company.client_id, company_id: @company.company_id)
#  end

  def set_change
    @change_history_to_company = ChangeHistoryToCompany.find_by(token: params[:token])
  end
end
