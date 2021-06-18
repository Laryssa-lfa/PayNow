require 'rails_helper'

describe 'Admin registers Pix' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Cadastrar PIX'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Chave PIX', with: '12345678909876543210'
    fill_in 'Taxa', with: '1.5'
    click_on 'Cadastrar'

    expect(current_path).to eq(search_payment_path)
    expect(page).to have_content('PIX criado com sucesso')
    expect(page).to have_content('Gerenciar Meios de Pagamento')
    expect(page).to have_content('PIX')
    expect(page).to have_link('Pesquisar')
    expect(page).to have_link('Cadastrar')
  end
end
