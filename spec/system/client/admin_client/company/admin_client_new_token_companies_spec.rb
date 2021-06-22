require 'rails_helper'

describe 'Admin_client requests new token for companies' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: admin_client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br', token: '1a2s3d4f5g6h7j8k9l')

    login_as admin_client, scope: 'client'
    visit admin_client_company_path(company)
    click_on 'Solicitar Novo Token'

    expect(page).to have_content('Token atualizado')
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
    #expect(page).to have_content(company.token)
    expect(page).to have_link('Solicitar Novo Token')
  end
end
