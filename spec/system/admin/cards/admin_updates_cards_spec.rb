require 'rails_helper'

describe 'Admin updates card' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    card = Card.create!(card_name: 'Vix', code: 12345678909876543210,
                        rate: 2, status: true, admin_id: admin.id)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar Cartão'
    fill_in 'Bandeira do Cartão', with: 'Vix'
    fill_in 'Código do Cartão', with: '12345678909876543210'
    click_on 'Pesquisar'
    click_on 'Editar'
    fill_in 'Código do Cartão', with: '22245678909876543210'
    click_on 'Editar'

    expect(current_path).to eq(search_payment_path)
    expect(page).to have_content('Cartão de Crédito atualizado com sucesso')
    expect(page).to have_content('Gerenciar Meios de Pagamento')
    expect(page).to have_content('Cartão de Crédito')
    expect(page).to have_link('Pesquisar')
    expect(page).to have_link('Cadastrar')
  end
end
