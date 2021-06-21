class Employee::CompaniesController < ApplicationController
  before_action :authenticate_admin!, only: %i[index show edit update]
  before_action :set_company, only: %i[show edit update]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @client = current_client
    @company = Company.new
    @company.client_id = @client.id
  end

  def create
    @client = current_client
    @company = Company.new(company_params)
    @company.client_id = @client.id
    
    if @company.save
      @company.status = true
      redirect_to employee_company_path(@company), notice: "Empresa cadastrada"
    else
      render :new, alert: "Empresa não cadastrada"
    end
  end

  def edit
  end

  def update
    @company.update(company_params)
    redirect_to employee_company_path(@company), notice: "Empresa atualizada"
  end

  private

  def company_params
    params.require(:company).permit(:cnpj, :corporate_name, :address, :email, :token,
                                    :status, :client_id)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
