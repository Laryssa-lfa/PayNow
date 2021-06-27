require 'rails_helper'

describe 'Admin_client view companies' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: admin_client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')

    login_as admin_client, scope: 'client'
    visit admin_client_company_path(company)

    expect(page).to have_content('Perfil CodePlay')
    expect(page).to have_content('CNPJ')
    expect(page).to have_content('12345678902')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Rua Nova, N: 200')
    expect(page).to have_content('E-mail')
    expect(page).to have_content('sac@codeplay.com.br')
    expect(page).to have_content('Status')
    expect(page).to have_content('Empresa habilitada')
    expect(page).to have_content('Token')
    expect(page).to have_content(company.token)
    expect(page).to have_link('Solicitar Novo Token')
  end

  it 'and return to home page' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: admin_client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')

    login_as admin_client, scope: 'client'
    visit admin_client_company_path(company)
    click_on 'PayNow'

    expect(current_path).to eq(root_path)
    expect(page).to have_content(admin_client.email)
    expect(page).to have_link('Consultar Cobranças')
    expect(page).to have_link('Gerenciar Produtos')
    expect(page).to have_link('Meios de Pagamento')
    expect(page).to have_link('Gerenciar Funcionários(as)')
  end
  
  it 'without admin_client' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 0)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: admin_client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')

    login_as admin_client, scope: 'client'
    visit admin_client_company_path(company)

    expect(page).to have_content('Acesso apenas pelo Administrador')
  end
end
