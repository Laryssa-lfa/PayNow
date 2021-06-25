require 'rails_helper'

xdescribe 'Admin view change history to companies' do
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
    click_on 'Histórico de Alterações'

    expect(current_path).to eq(employee_change_history_to_companies_path)
    expect(page).to have_content('Histórico de Alterações: CodePlay')
    expect(page).to have_content('Alterado em:')
    expect(page).to have_content(company.created_at)
    expect(page).to have_content(Date.today)
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
    visit employee_change_history_to_companies_path
    click_on 'Detalhes'

    expect(current_path).to eq(employee_change_history_to_company_path(company))
    expect(page).to have_content('Detalhes')
    expect(page).to have_content('Razão Social')
    expect(page).to have_content('CodePlay')
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
    expect(page).to have_content('Criado em')
    expect(page).to have_content(company.created_at)
    expect(page).to have_content('Alterado em')
    expect(page).to have_content(company.updated_at)
  end
end
