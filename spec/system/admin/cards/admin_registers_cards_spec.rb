require 'rails_helper'

describe 'Admin registers card' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Cadastrar Cartão'
    fill_in 'Bandeira do Cartão', with: 'Vix'
    fill_in 'Código do Cartão', with: '12345678909876543210'
    fill_in 'Taxa', with: '2'
    click_on 'Cadastrar'

    expect(current_path).to eq(search_payment_path)
    expect(page).to have_content('Cartão de Crédito criado com sucesso')
    expect(page).to have_content('Gerenciar Meios de Pagamento')
    expect(page).to have_content('Cartão de Crédito')
    expect(page).to have_link('Pesquisar')
    expect(page).to have_link('Cadastrar')
  end
end
