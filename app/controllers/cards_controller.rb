class CardsController < ApplicationController
  before_action :authenticate_admin!, only: %i[index new create search_boleto]
  before_action :authenticate_client!, only: %i[edit update]
  before_action :set_card, only: %i[show edit update]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @admin = current_admin
    @card = Card.new
  end

  def create
    @admin = current_admin
    @card = Card.new(card_params)
    @card.admin_id = @admin.id
    if @card.save
      #redirect_to search_path, notice: t('.success')
      redirect_to search_payment_path, notice: 'Cartão de Crédito criado com sucesso'
    else
      render :new, alert: 'Cartão de Crédito não criado'
    end
  end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin
    @card.update(card_params)
    redirect_to payment_method_admin_client_companies_path, notice: 'Cartão de Crédito ativado'
  end

  def search_card
    @cards = Card.where('card_name = ? AND code = ?',
                         params[:q], params[:u])
  end

  private

  def card_params
    params.require(:card).permit(:card_name, :rate, :status, :code, :admin_id)
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
