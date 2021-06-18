require 'rails_helper'

describe 'Admin search card' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    card = Card.create!(card_name: 'Vix', code: 12345678909876543210,
                        rate: 2, status: true, admin_id: admin.id)
    Card.create!(card_name: 'Maestro', code: 99874561230258369147,
                 rate: 3, status: false, admin_id: admin.id)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar Cartão'
    fill_in 'Bandeira do Cartão', with: 'Vix'
    fill_in 'Código do Cartão', with: '12345678909876543210'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_card_path)
    expect(page).to have_content('Cartões Encontrados')
    expect(page).to have_content('Bandeira do Cartão')
    expect(page).to have_content('Vix')
    expect(page).to have_content('Código do Cartão')
    expect(page).to have_content('12345678909876543210')
    expect(page).to have_content('Taxa')
    expect(page).to have_content('2.00%')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ativado')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Voltar')
    expect(page).to_not have_content('Maestro')
    expect(page).to_not have_content('99874561230258369147')
    expect(page).to_not have_content('3.00%')
    expect(page).to_not have_content('Desativado')
  end

  it 'and does not have card' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar Cartão'
    fill_in 'Bandeira do Cartão', with: 'Vix'
    fill_in 'Código do Cartão', with: '12345678909876543210'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_card_path)
    expect(page).to have_content('Nenhum Cartão Encontrado')
    expect(page).to_not have_content('Bandeira do Cartão')
    expect(page).to_not have_content('Vix')
    expect(page).to_not have_content('Código do Cartão')
    expect(page).to_not have_content('12345678909876543210')
  end
end
