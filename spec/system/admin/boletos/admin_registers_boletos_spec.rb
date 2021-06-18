require 'rails_helper'

describe 'Admin registers boleto' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Cadastrar Boleto'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Agência Bancária', with: '185'
    fill_in 'Conta Bancária', with: '323561'
    fill_in 'Taxa', with: '2.5'
    click_on 'Cadastrar'

    expect(current_path).to eq(search_payment_path)
    expect(page).to have_content('Boleto cadastrado com sucesso')
    expect(page).to have_content('Gerenciar Meios de Pagamento')
    expect(page).to have_content('Boleto Bancário')
    expect(page).to have_link('Pesquisar')
    expect(page).to have_link('Cadastrar')
  end
end
