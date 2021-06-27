require 'rails_helper'

describe 'Admin update companies' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'Codplay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Clientes'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'CodePlay'
    fill_in 'CNPJ', with: '12345678902'
    fill_in 'Endereço', with: 'Rua Nova, N: 400'
    fill_in 'E-mail', with: 'sac@codeplay.com.br'
    click_on 'Editar Empresa'
    
    expect(current_path).to eq(employee_company_path(company))
    expect(page).to have_content('Detalhes CodePlay')
    expect(page).to have_text('CNPJ')
    expect(page).to have_text('12345678902')
    expect(page).to have_text('Endereço')
    expect(page).to have_text('Rua Nova, N: 400')
    expect(page).to have_text('E-mail')
    expect(page).to have_text('sac@codeplay.com.br')
    expect(page).to have_text('Status')
    expect(page).to have_text('Empresa habilitada')
    expect(page).to have_text('Token')
    expect(page).to have_text(company.token)
    expect(page).to have_link('Voltar')
  end

  it 'must be logged in to update companies' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                            password: '123456', role: 1)
    company = Company.create!(corporate_name: 'Codplay', cnpj: '12345678902', status: true,
                              client_id: client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')

    visit edit_employee_company_path(company)

    expect(current_path).to eq(admin_session_path)
    #expect(page).to have_content('Você precisa entrar ou se inscrever antes de continuar.')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
