class AdminClient::CompaniesController < ApplicationController
  before_action :authenticate_client!, only: %i[show new create]

  def index
  end

  def show
    @company = Company.find(params[:id])
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
      redirect_to admin_client_company_path(@company), notice: "Empresa cadastrada com sucesso"
    else
      render :new, alert: "Empresa não cadastrada"
    end
  end

  def edit
  end

  def update
  end

  private

  def company_params
    params.require(:company).permit(:cnpj, :corporate_name, :address, :email, :token,
                                    :status, :client_id)
  end
end
