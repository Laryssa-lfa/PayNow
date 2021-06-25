require 'rails_helper'

describe 'Client deletes products' do
  it 'successfully' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')
    product = Product.create!(name: 'Ruby', price: '20', token: '1a2s3d4f5g6h7j8k9l0',
                              type_payment: 'PIX', company_id: company.id)
    product2 = Product.create!(name: 'Rails Tests', price: '20', token: 'g6h7j8k9l01a2s3d4f5',
                               discount: '10', type_payment: 'Boleto Bancário', company_id: company.id)

    login_as client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Ruby'
    expect { click_on 'Apagar' }.to change { Product.count }.by(-1)

    expect(page).to have_text('Produto apagado com sucesso')
    expect(current_path).to eq(admin_client_products_path)
  end
end
