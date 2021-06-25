class BoletosController < ApplicationController
  before_action :authenticate_admin!, only: %i[index new create search_boleto]
  before_action :authenticate_client!, only: %i[edit update]
  before_action :set_boleto, only: %i[show edit update]

  def index
    @boletos = Boleto.all
  end

  def show
  end

  def new
    @admin = current_admin
    @boleto = Boleto.new
  end

  def create
    @admin = current_admin
    @boleto = Boleto.new(boleto_params)
    @boleto.admin_id = @admin.id
    if @boleto.save!
      #redirect_to search_payment_path, notice: t('.success')
      redirect_to search_payment_path, notice: 'Boleto cadastrado com sucesso'
    else
      render :new, alert: 'Boleto não cadastrado'
    end
  end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin
    @boleto.update(boleto_params)
    redirect_to payment_method_admin_client_companies_path, notice: 'Boleto ativado'
  end

  def search_boleto
    @boletos = Boleto.where('bank_code = ? AND bank_agency = ? AND bank_account = ?',
                             params[:q], params[:u], params[:e])
  end

  private

  def boleto_params
    params.require(:boleto).permit(:rate, :status, :bank_code, :bank_agency,
                                   :bank_account, :admin_id)
  end

  def set_boleto
    @boleto = Boleto.find(params[:id])
  end
end
