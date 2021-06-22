require 'rails_helper'

describe 'Admin_client deletes employee' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')
    
    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Gerenciar Funcionários(as)'
    click_on 'Paulo'
    expect { click_on 'Apagar' }.to change { Client.count }.by(-1)

    expect(page).to have_text('Funcionário(a) apagado com sucesso')
    expect(current_path).to eq(admin_client_clients_path)
  end

  it 'must be logged in to delete employee' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456', role: 1)
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')
    
    visit admin_client_client_path(funcionario)

    expect(current_path).to eq(client_session_path)
  end

  it 'must be admin_client to delete employee' do
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')
    funcionario = Client.create!(name: 'Paulo', email: 'paulo@codeplay.com.br', password: '654321')
    
    login_as client, scope: 'client'
    visit admin_client_client_path(funcionario)

    expect(page).to have_content('Acesso apenas pelo Administrador')
  end
end
