require 'rails_helper'

describe 'Admin_client view other employees' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Funcionários(as)'

    expect(current_path).to eq(admin_client_clients_path)
    expect(page).to have_link('Registrar Funcionário(a)', href: new_admin_client_client_path)
    expect(page).to have_link('Maria', href: admin_client_client_path(admin_client))
    expect(page).to have_link('Paulo', href: admin_client_client_path(funcionario))
  end

  it 'and view details' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Funcionários(as)'
    click_on 'Paulo'

    expect(current_path).to eq(admin_client_client_path(funcionario))
    expect(page).to have_content(funcionario.name)
    expect(page).to have_content(funcionario.email)
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'and return to home page' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')

    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Funcionários(as)'
    click_on 'Paulo'
    click_on 'PayNow'

    expect(current_path).to eq root_path
    expect(page).to have_content(admin_client.email)
    expect(page).to have_link('Gerenciar Funcionários(as)')
    expect(page).to have_link('Meios de Pagamento')
    expect(page).to have_link('Sair')
  end

  it 'must be admin_client to view employee' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')
    
    login_as client, scope: 'client'
    visit admin_client_clients_path

    expect(page).to have_content('Acesso apenas pelo Administrador')
  end
end
