class AdminClient::ClientsController < ApplicationController
  before_action :authenticate_client!
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to admin_client_client_path(@client), notice: "Funcionário(a) cadastrado com sucesso"
    else
      render :new, alert: "Funcionário(a) não cadastrado"
    end
  end

  def edit
  end

  def update
    @client.update(client_params)
    redirect_to admin_client_client_path(@client), notice: "Funcionário(a) atualizado com sucesso"
  end

  def destroy
    @client.destroy
    redirect_to admin_client_clients_path, notice: "Funcionário(a) apagado com sucesso"
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :password)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
