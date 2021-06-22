require 'rails_helper'

describe 'Admin view companies' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Clientes'

    expect(current_path).to eq(employee_companies_path)
    expect(page).to have_content('Empresas Disponíveis')
    expect(page).to have_content('CodePlay')
    expect(page).to have_link('Suspender')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Detalhes')
  end

  it 'and view details' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

    login_as admin, scope: 'admin'
    visit employee_companies_path
    click_on 'Detalhes'

    expect(current_path).to eq(employee_company_path(company))
    expect(page).to have_content('Detalhes CodePlay')
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
    expect(page).to have_link('Voltar')
  end

  it 'and return to home page' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Clientes'
    click_on 'Detalhes'
    click_on 'PayNow'

    expect(current_path).to eq(root_path)
    expect(page).to have_content(admin.email)
    expect(page).to have_link('Gerenciar Funcionários(as)')
    expect(page).to have_link('Gerenciar Clientes')
    expect(page).to have_link('Gerenciar Meios de Pagamento')
  end

  it 'without registered companies' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Clientes'

    expect(page).to have_content('Nenhuma Empresa Disponível')
  end

  it 'must be logged in to view companies' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'Codplay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

    visit employee_companies_path

    expect(current_path).to eq(admin_session_path)
    #expect(page).to have_content('Você precisa entrar ou se inscrever antes de continuar.')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
