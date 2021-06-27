require 'rails_helper'

describe 'Client updates products' do
  it 'successfully' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')
    product = Product.create!(name: 'Ruby', price: '20', type_payment: 'PIX',
                              company_id: company.id)
    product2 = Product.create!(name: 'Rails Tests', price: '20', discount: '10',
                               type_payment: 'Boleto Bancário', company_id: company.id)

    login_as client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Ruby'
    click_on 'Editar'
    fill_in 'Preço:', with: '30'
    fill_in 'Desconto:', with: '10'
    click_on 'Editar Produto'

    expect(current_path).to eq(admin_client_product_path(product))
    expect(page).to have_content('Detalhes Ruby')
    expect(page).to have_content('Preço: R$ 30,00')
    expect(page).to have_content('Desconto: R$ 10,00')
    expect(page).to have_content('Tipo de Pagamento: PIX')
    expect(page).to have_content('Token:')
    expect(page).to have_content(product.token)
    expect(page).to have_content('Criado em:')
    expect(page).to have_content(product.created_at)
    expect(page).to have_content('Atualizado em:')
    expect(page).to have_content(product.updated_at)
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'must be logged in to update products' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')
    product = Product.create!(name: 'Ruby', price: '20', type_payment: 'PIX',
                              company_id: company.id)

    visit edit_admin_client_product_path(product)

    expect(current_path).to eq(new_client_session_path)
  end
end
