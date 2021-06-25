require 'rails_helper'

describe 'Client activate payments methods' do
  it 'activate successfully boleto' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br', occupation: 'Gerente',
                          password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                    client_id: client.id, address: 'Rua Nova, N: 200',
                    email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')
    boleto = Boleto.create!(rate: 3, status: true, admin_id: admin.id)

    login_as client, scope: 'client'
    visit root_path
    click_on 'Meios de Pagamento'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Agência Bancária', with: '185'
    fill_in 'Conta Bancária', with: '323561'
    click_on 'Ativar Boleto'

    expect(current_path).to eq(payment_method_admin_client_companies_path)
    expect(page).to have_content('Boleto ativado')
    expect(page).to have_content('Ativar Meios de Pagamento')
    expect(page).to have_content('Boleto Bancário')
    expect(page).to have_content('Taxa: 3.00%')
    expect(page).to have_content('Código do Banco')
    expect(page).to have_content('Agência Bancária')
    expect(page).to have_content('Conta Bancária')
  end
  
  it 'activate successfully card' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br', occupation: 'Gerente',
                          password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                    client_id: client.id, address: 'Rua Nova, N: 200',
                    email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')
    card = Card.create!(card_name: 'Vix', rate: 2, status: true, admin_id: admin.id)

    login_as client, scope: 'client'
    visit root_path
    click_on 'Meios de Pagamento'
    fill_in 'Código do Cartão', with: '12345678909876543210'
    click_on 'Ativar Cartão'

    expect(current_path).to eq(payment_method_admin_client_companies_path)
    expect(page).to have_content('Cartão de Crédito ativado')
    expect(page).to have_content('Ativar Meios de Pagamento')
    expect(page).to have_content('Cartão de Crédito')
    expect(page).to have_content('Bandeira: Vix')
    expect(page).to have_content('Taxa: 2.00%')
    expect(page).to have_content('Código do Cartão')
  end
  
  it 'activate successfully pix' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br', occupation: 'Gerente',
                          password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                    client_id: client.id, address: 'Rua Nova, N: 200',
                    email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')
    Pix.create!(rate: 2, status: true, admin_id: admin.id)

    login_as client, scope: 'client'
    visit root_path
    click_on 'Meios de Pagamento'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Chave PIX', with: '12345678909876543210'
    click_on 'Ativar PIX'

    expect(current_path).to eq(payment_method_admin_client_companies_path)
    expect(page).to have_content('PIX ativado')
    expect(page).to have_content('Ativar Meios de Pagamento')
    expect(page).to have_content('PIX')
    expect(page).to have_content('Taxa: 2.00%')
    expect(page).to have_content('Chave PIX')
    expect(page).to have_content('Código do Banco')
  end
end
