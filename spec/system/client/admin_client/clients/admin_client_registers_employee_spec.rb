require 'rails_helper'

describe 'Admin_client registers employees' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)

    login_as admin_client, scope: 'client'
    visit admin_client_clients_path
    click_on 'Registrar Funcionário(a)'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@codeplay.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Registrar Funcionário(a)'

    expect(page).to have_content('Paulo')
    expect(page).to have_content('paulo@codeplay.com.br')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'must be admin to register employee' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    login_as client, scope: 'client'
    visit new_admin_client_client_path

    expect(page).to have_content('Acesso apenas pelo Administrador')
  end

  it 'and attributes cannot be blank' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)

    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Funcionários(as)'
    click_on 'Registrar Funcionário(a)'
    click_on 'Registrar Funcionário(a)'

    #expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content("Email can't be blank")
    #expect(page).to have_content("Senha não pode ficar em branco")
    expect(page).to have_content("Password can't be blank")
    #expect(page).to have_content('E-mail muito curto (minimo de 4 caracteres)')
    expect(page).to have_content('Email is too short (minimum is 4 characters)')
  end

  it 'and email must be unique' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    login_as admin_client, scope: 'client'
    visit admin_client_clients_path
    click_on 'Registrar Funcionário(a)'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@codeplay.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Registrar Funcionário(a)'
    
    #expect(page).to have_content('já está em uso')
    expect(page).to have_content('Email has already been taken')
  end

  it 'and email invalid' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)

    login_as admin_client, scope: 'client'
    visit admin_client_clients_path
    click_on 'Registrar Funcionário(a)'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@paynow.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Registrar Funcionário(a)'

    expect(page).to have_content('Email inválido')
  end
end
