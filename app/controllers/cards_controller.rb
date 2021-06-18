class CardsController < ApplicationController
  before_action :authenticate_admin!, only: %i[index show new edit create update search_card]
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
    #redirect_to search_path, notice: t('.success')
    redirect_to search_payment_path, notice: 'Cartão de Crédito atualizado com sucesso'
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
