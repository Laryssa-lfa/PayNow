class PixesController < ApplicationController
  before_action :authenticate_admin!, only: %i[index show new edit create update search_pix]
  before_action :set_pix, only: %i[show edit update]

  def index
    @pixes = Pix.all
  end

  def show
  end

  def new
    @admin = current_admin
    @pix = Pix.new
  end

  def create
    @admin = current_admin
    @pix = Pix.new(pix_params)
    @pix.admin_id = @admin.id
    if @pix.save
      #redirect_to search_path, notice: t('.success')
      redirect_to search_payment_path, notice: 'PIX criado com sucesso'
    else
      render :new, alert: 'PIX não cadastrado'
    end
  end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin
    @pix.update(pix_params)
    #redirect_to search_path, notice: t('.success')
    redirect_to search_payment_path, notice: 'PIX atualizado com sucesso'
  end
  
  def search_pix
    @pixes = Pix.where('code = ? AND bank_code = ?',
                        params[:q], params[:u])
  end

  private

  def pix_params
    params.require(:pix).permit(:rate, :status, :code, :bank_code, :admin_id)
  end

  def set_pix
    @pix = Pix.find(params[:id])
  end
end
