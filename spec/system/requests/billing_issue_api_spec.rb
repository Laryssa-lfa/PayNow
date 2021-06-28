require 'rails_helper'

describe 'Billing_issue API' do
  context 'GET /api/v1/billing_issues' do
    it 'should not return a billing_issue without any token' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br')
      product = Product.create!(name: 'Ruby', price: '20', type_payment: 'Cartão de Crédito',
                                company_id: company.id)
      end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                     company_token: company.token)
      billing_issue = 
        BillingIssue.create!(company_token: company.token, product_token: product.token,
                             end_client_token: end_client.token, card_number: '123456789',
                             name_client_card: 'Paulo Pereira', verification_code: '332',
                             type_payment: product.type_payment)

      get '/api/v1/billing_issues'

      expect(response).to have_http_status(404)
    end
  end
  
  context 'GET /api/v1/billing_issues/:token' do
    it 'should return a billing_issue with token' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br')
      product = Product.create!(name: 'Ruby', price: '20', type_payment: 'Cartão de Crédito',
                                company_id: company.id)
      end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                     company_token: company.token)
      billing_issue = 
        BillingIssue.create!(company_token: company.token, product_token: product.token,
                             end_client_token: end_client.token, card_number: '123456789',
                             name_client_card: 'Paulo Pereira', verification_code: '332',
                             type_payment: product.type_payment)

      get "/api/v1/billing_issues/#{billing_issue.token}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['company_token']).to include(company.token)
      expect(parsed_body['product_token']).to include(product.token)
      expect(parsed_body['end_client_token']).to include(end_client.token)
      expect(parsed_body['type_payment']).to include(product.type_payment)
      expect(parsed_body['card_number']).to include( '123456789')
      expect(parsed_body['name_client_card']).to include('Paulo Pereira')
      expect(parsed_body['verification_code']).to include('332')
      expect(parsed_body['price_product']).to eq('20.0')
      expect(parsed_body['status']).to eq(false)
    end

    it 'should not found billing_issue by token invalid' do
      get '/api/v1/billing_issues/ABC1234'

      expect(response).to have_http_status(404)
    end
  end

  context 'POST /api/v1/billing_issues' do
    it 'should create a billing_issue' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br')
      product = Product.create!(name: 'Ruby', price: '20', type_payment: 'Boleto Bancário',
                                company_id: company.id)
      end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                     company_token: company.token)

      post '/api/v1/billing_issues/', params: {
        billing_issue: { company_token: company.token, product_token: product.token,
                        end_client_token: end_client.token, type_payment: product.type_payment,
                        full_address: 'Av. Principal, N: 300' }
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['company_token']).to eq(company.token)
      expect(parsed_body['product_token']).to eq(product.token)
      expect(parsed_body['end_client_token']).to eq(end_client.token)
      expect(parsed_body['full_address']).to eq('Av. Principal, N: 300')
      expect(parsed_body['price_product']).to eq('20.0')
      expect(parsed_body['status']).to eq(false)
    end

    it 'should create a billing_issue with discount' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br')
      product = Product.create!(name: 'Ruby', price: '50', type_payment: 'Boleto Bancário',
                                discount: '10', company_id: company.id)
      end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                     company_token: company.token)

      post '/api/v1/billing_issues/', params: {
        billing_issue: { company_token: company.token, product_token: product.token,
                        end_client_token: end_client.token, type_payment: product.type_payment,
                        full_address: 'Av. Principal, N: 300' }
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['company_token']).to eq(company.token)
      expect(parsed_body['product_token']).to eq(product.token)
      expect(parsed_body['end_client_token']).to eq(end_client.token)
      expect(parsed_body['full_address']).to eq('Av. Principal, N: 300')
      expect(parsed_body['price_product']).to eq('50.0')
      expect(parsed_body['price_discount']).to eq('40.0')
      expect(parsed_body['status']).to eq(false)
    end

    it 'should not create a billing_issue without parameters' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                    password: '123456', role: 1)
      company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                                client_id: admin_client.id, address: 'Rua Nova, N: 200',
                                email: 'sac@codeplay.com.br')
      product = Product.create!(name: 'Ruby', price: '20', type_payment: 'Boleto Bancário',
                                company_id: company.id)
      end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                     company_token: company.token)

      post '/api/v1/billing_issues/'

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('parâmetros inválidos')
    end
  end
end
