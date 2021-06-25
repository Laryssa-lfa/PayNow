require 'rails_helper'

describe 'Client registers products' do
  it 'successfully' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')

    login_as client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Cadastrar Produtos'
    fill_in 'Nome:', with: 'Ruby'
    fill_in 'Preço:', with: '50'
    fill_in 'Desconto:', with: '20'
    fill_in 'Tipo de pagamento:', with: 'Boleto'
    click_on 'Cadastrar Produto'

    expect(page).to have_content('Detalhes Ruby')
    expect(page).to have_content('Preço: R$ 50,00')
    expect(page).to have_content('Desconto: R$ 20,00')
    expect(page).to have_content('Tipo de Pagamento: Boleto')
    expect(page).to have_content('Token:')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l1')

    login_as client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Produtos'
    click_on 'Cadastrar Produtos'
    click_on 'Cadastrar Produto'

    #expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content("Name can't be blank")
    #expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content("Price can't be blank")
    #expect(page).to have_content('Preço não pode ficar em branco')
    expect(page).to have_content("Type payment can't be blank")
    #expect(page).to have_content('Tipo de pagamento não pode ficar em branco')
  end

  it 'must be authentication to register product' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')

    visit new_admin_client_product_path

    expect(current_path).to have_content(client_session_path)
  end
end
