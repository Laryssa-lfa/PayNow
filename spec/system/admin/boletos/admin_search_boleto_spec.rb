require 'rails_helper'

describe 'Admin search boleto' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    boleto = Boleto.create!(bank_code: 001, bank_agency: 733,
                            bank_account: 18189, rate: 3, status: true, admin_id: admin.id)
    Boleto.create!(bank_code: 033, bank_agency: 185,
                   bank_account: 18189, rate: 2.5, status: false, admin_id: admin.id)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar Boleto'
    fill_in 'Código do Banco', with: '001'
    fill_in 'Agência Bancária', with: '733'
    fill_in 'Conta Bancária', with: '18189'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_boleto_path)
    expect(page).to have_content('Boletos Encontrados')
    expect(page).to have_content('Código do Banco')
    expect(page).to have_content('1')
    expect(page).to have_content('Agência Bancária')
    expect(page).to have_content('733')
    expect(page).to have_content('Conta Bancária')
    expect(page).to have_content('18189')
    expect(page).to have_content('Taxa')
    expect(page).to have_content('3.00%')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ativado')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Voltar')
    expect(page).to_not have_content('033')
    expect(page).to_not have_content('185')
    expect(page).to_not have_content('2.5%')
    expect(page).to_not have_content('Desativado')
  end

  it 'and does not have boleto' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar Boleto'
    fill_in 'Código do Banco', with: '001'
    fill_in 'Agência Bancária', with: '733'
    fill_in 'Conta Bancária', with: '18189'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_boleto_path)
    expect(page).to have_content('Nenhum Boleto Encontrado')
    expect(page).to_not have_content('Boletos Encontrados')
    expect(page).to_not have_content('Código do Banco')
    expect(page).to_not have_content('1')
    expect(page).to_not have_content('Agência Bancária')
    expect(page).to_not have_content('733')
    expect(page).to_not have_content('Conta Bancária')
    expect(page).to_not have_content('18189')
  end
end
