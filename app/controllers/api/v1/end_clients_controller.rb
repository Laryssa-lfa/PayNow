class Api::V1::EndClientsController < Api::V1::ApiController
  
  def create
    #@company = Company.find_by(token: params[:company_token])
    @end_client = EndClient.new(end_client_params)
    @end_client.save!
    #@company.company_end_clients.create!(end_client: @end_client)
    render json: @end_client, status: :created
  end

  private

  def end_client_params
    params.require(:end_client).permit(:name, :cpf, :token, :company_token)
  end
end
