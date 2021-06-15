require 'rails_helper'

describe 'Admin registers admins' do
  it 'successfully' do
    manager = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                            occupation: 'Gerente', password: '123456')

    login_as manager, scope: 'admin'
    visit employee_admins_path
    click_on 'Registrar Funcionários'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@paynow.com.br'
    fill_in 'Função', with: 'Desenvolvedor'
    fill_in 'Senha', with: '123456'
    click_on 'Criar Funcionário'

    expect(page).to have_content('Paulo')
    expect(page).to have_content('paulo@paynow.com.br')
    expect(page).to have_content('Desenvolvedor')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    manager = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                            occupation: 'Gerente', password: '123456')

    login_as manager, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Funcionários'
    click_on 'Registrar Funcionários'
    click_on 'Criar Funcionário'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('é obrigatório')
  end

  it 'and email must be unique' do
    manager = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                            occupation: 'Gerente', password: '123456')
    Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                  occupation: 'Desenvolvedor', password: '654321')

    login_as manager, scope: 'admin'
    visit employee_admins_path
    click_on 'Registrar Funcionários'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@paynow.com.br'
    fill_in 'Função', with: 'Desenvolvedor'
    fill_in 'Senha', with: '123456'
    click_on 'Criar Funcionário'
    
    expect(page).to have_content('já está em uso')
  end
end
