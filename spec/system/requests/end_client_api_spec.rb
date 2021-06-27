require 'rails_helper'

describe 'End_client API' do
  context 'POST /api/v1/end_clients' do
    it 'should create a end_client' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

      post '/api/v1/end_clients', params: {
        end_client: { name: 'Maria Silva', cpf: 12345678912, company_token: company.token }
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['name']).to eq('Maria Silva')
      expect(parsed_body['cpf']).to eq(12345678912)
      expect(parsed_body['company_token']).to eq(company.token)
    end
    
    it 'should not create a end_client with invalid params' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

      post '/api/v1/end_clients', params: { end_client: { number: 10 } }

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['name']).to eq(["can't be blank"])
      expect(parsed_body['cpf']).to include("can't be blank")
      expect(parsed_body['cpf']).to include('Deve conter 11 caracteres')
    end
    
    it 'should not create a end_client without parameters' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

      post '/api/v1/end_clients'

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('parâmetros inválidos')
    end
    
    it 'should not create a end_client with same token and company' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')
      endClient = EndClient.create!(name: 'Maria Silva', cpf: '12345678912',
                                    company_token: company.token)

      post '/api/v1/end_clients', params: { end_client: { name: 'paulo',
        cpf: '12345678912', token: endClient.token, company_token: company.token }
      }

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('has already been taken')
    end
  end
end
