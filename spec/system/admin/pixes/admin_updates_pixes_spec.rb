require 'rails_helper'

describe 'Admin updates Pix' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    pix = Pix.create!(bank_code: '033', code: 12345678909876543210,
                      rate: 1.5, status: true, admin_id: admin.id)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Meios de Pagamento'
    click_on 'Pesquisar PIX'
    fill_in 'Código do Banco', with: '033'
    fill_in 'Chave PIX', with: '12345678909876543210'
    click_on 'Pesquisar'
    click_on 'Editar'
    fill_in 'Chave PIX', with: '22245678909876543223'
    click_on 'Editar'

    expect(current_path).to eq(search_payment_path)
    expect(page).to have_content('PIX atualizado com sucesso')
    expect(page).to have_content('Gerenciar Meios de Pagamento')
    expect(page).to have_content('PIX')
    expect(page).to have_link('Pesquisar')
    expect(page).to have_link('Cadastrar')
  end
end
