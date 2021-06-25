class AdminClient::ProductsController < ApplicationController
  before_action :authenticate_client!
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @company = current_client.company_ids
    @product = Product.new
    @product.company_id = @company[0]
  end

  def create
    @company = current_client.company_ids
    @product = Product.new(product_params)
    @product.company_id = @company[0]
    @product.generate_token

    if @product.save
      redirect_to admin_client_product_path(@product), notice: "Produto cadastrado com sucesso"
    else
      render :new, notice: "Produto não cadastrado"
    end
  end

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to admin_client_product_path(@product), notice: "Produto atualizado com sucesso"
  end

  def destroy
    @product.destroy
    redirect_to admin_client_products_path, notice: "Produto apagado com sucesso"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :discount, :type_payment,
                                    :token, :company_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end


# TODO: inverter associação de cliente e empresa
# TODO: Fazer o histórico das alterações