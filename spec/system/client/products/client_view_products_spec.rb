require 'rails_helper'

describe 'Client view products' do
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

    expect(current_path).to eq(admin_client_products_path)
    expect(page).to have_link('Cadastrar Produtos')
    expect(page).to have_content('Produtos Disponíveis')
    expect(page).to have_content('Nome: Ruby')
    expect(page).to have_link('Ruby', href: admin_client_product_path(product))
    expect(page).to have_content('Preço: R$ 20,00')
    expect(page).to have_content('Nome: Rails Tests')
    expect(page).to have_link('Rails Tests', href: admin_client_product_path(product2))
    expect(page).to have_content('Preço: R$ 20,00')
  end

  it 'and view details' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')
    product = Product.create!(name: 'Ruby', price: '20', token: '1a2s3d4f5g6h7j8k9l0',
                              type_payment: 'PIX', company_id: company.id)
    product2 = Product.create!(name: 'Rails Tests', price: '30', token: 'g6h7j8k9l01a2s3d4f5',
                               discount: '10', type_payment: 'Boleto Bancário', company_id: company.id)

    login_as client, scope: 'client'
    visit admin_client_products_path
    click_on 'Ruby'

    expect(current_path).to eq(admin_client_product_path(product))
    expect(page).to have_content('Detalhes Ruby')
    expect(page).to have_content('Preço: R$ 20,00')
    expect(page).to have_content('Desconto:')
    expect(page).to have_content('Tipo de Pagamento: PIX')
    expect(page).to have_content('Token: 1a2s3d4f5g6h7j8k9l0')
    expect(page).to have_content('Criado em:')
    expect(page).to have_content(product.created_at)
    expect(page).to have_content('Atualizado em:')
    expect(page).to have_content(product.updated_at)
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
    expect(page).to_not have_content('Rails Test')
    expect(page).to_not have_content('Preço: R$ 30,00')
    expect(page).to_not have_content('Desconto: R$ 10,00')
    expect(page).to_not have_content('Tipo de Pagamento: Boleto Bancário')
    expect(page).to_not have_content('Token: g6h7j8k9l01a2s3d4f5')
  end

  it 'must be authentication to view product' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')
    product = Product.create!(name: 'Ruby', price: '20', token: '1a2s3d4f5g6h7j8k9l0',
                              type_payment: 'PIX', company_id: company.id)

    visit admin_client_products_path

    expect(current_path).to have_content(client_session_path)
  end

  it 'without registered product' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')

    login_as client, scope: 'client'
    visit admin_client_products_path

    expect(page).to have_link('Cadastrar Produtos')
    expect(page).to have_content('Não tem Produtos Disponíveis')
  end
end
