require 'rails_helper'

describe 'Admin search Pix' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    pix = Pix.create!(bank_code: '033', code: 12345678909876543210,
                      rate: 1.5, status: true, admin_id: admin.id)
    Pix.create!(bank_code: '001', code: 99874561230258369147,
                rate: 2, status: false, admin_id: admin.id)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar PIX'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Chave PIX', with: '12345678909876543210'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_pix_path)
    expect(page).to have_content('PIX Encontrados')
    expect(page).to have_content('Chave PIX')
    expect(page).to have_content('12345678909876543210')
    expect(page).to have_content('Código do Banco')
    expect(page).to have_content('33')
    expect(page).to have_content('Taxa')
    expect(page).to have_content('1.50%')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ativado')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Voltar')
    expect(page).to_not have_link('001')
    expect(page).to_not have_link('99874561230258369147')
    expect(page).to_not have_link('2.00%')
    expect(page).to_not have_link('Desativado')
  end

  it 'and does not have Pix' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar PIX'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Chave PIX', with: '12345678909876543210'
    click_on 'Pesquisar'

    expect(current_path).to eq(search_pix_path)
    expect(page).to have_content('Nenhum PIX Encontrado')
    expect(page).to_not have_content('PIX Encontrados')
    expect(page).to_not have_content('Chave PIX')
    expect(page).to_not have_content('12345678909876543210')
    expect(page).to_not have_content('Código do Banco')
    expect(page).to_not have_content('33')
  end
end
