require 'rails_helper'

describe 'Admin_client updates employees' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Funcionários(as)'
    click_on 'Paulo'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paulo'
    fill_in 'E-mail', with: 'paulo@codeplay.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Editar Funcionário(a)'

    expect(page).to have_content('Paulo')
    expect(page).to have_content('paulo@codeplay.com.br')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'must be logged in to update employees' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    visit edit_admin_client_client_path(funcionario)

    expect(current_path).to eq(new_client_session_path)
  end

  it 'must be admin_client to update employee' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')
    
    login_as client, scope: 'client'
    visit edit_admin_client_client_path(funcionario)

    expect(page).to have_content('Acesso apenas pelo Administrador')
  end
end
