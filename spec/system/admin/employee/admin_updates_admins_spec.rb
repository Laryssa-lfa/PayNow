require 'rails_helper'

describe 'Admin updates admins' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Dev', password: '654321')

    login_as admin, scope: 'admin'
    visit employee_admin_path(funcionario)
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@paynow.com.br'
    fill_in 'Função', with: 'Desenvolvedor'
    fill_in 'Senha', with: '123456'
    click_on 'Editar Funcionário(a)'

    expect(page).to have_content('Paulo')
    expect(page).to have_content('paulo@paynow.com.br')
    expect(page).to have_content('Desenvolvedor')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'must be logged in to update admins' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Dev', password: '654321')

    visit edit_employee_admin_path(funcionario)

    expect(current_path).to eq(new_admin_session_path)
  end
end
