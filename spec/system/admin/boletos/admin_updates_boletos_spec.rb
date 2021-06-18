require 'rails_helper'

describe 'Admin updates boleto' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    boleto = Boleto.create!(bank_code: 001, bank_agency: 733,
                            bank_account: 18189, rate: 3, status: true, admin_id: admin.id)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar Boleto'
    fill_in 'Código do Banco', with: '001'
    fill_in 'Agência Bancária', with: '733'
    fill_in 'Conta Bancária', with: '18189'
    click_on 'Pesquisar'
    click_on 'Editar'
    fill_in 'Conta Bancária', with: '18188'
    click_on 'Editar'

    expect(current_path).to eq(search_payment_path)
    expect(page).to have_content('Boleto atualizado com sucesso')
    expect(page).to have_content('Gerenciar Meios de Pagamento')
    expect(page).to have_content('Boleto Bancário')
    expect(page).to have_link('Pesquisar')
    expect(page).to have_link('Cadastrar')
  end
end
