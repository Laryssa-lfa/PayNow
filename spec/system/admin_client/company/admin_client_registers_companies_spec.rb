require 'rails_helper'

describe 'Admin_client registers companies' do
  it 'successfully' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)

    login_as admin_client, scope: 'client'
    visit root_path
    click_on 'Cadastrar Empresa'
    fill_in 'Razão Social', with: 'CodePlay'
    fill_in 'CNPJ', with: '12345678902'
    fill_in 'Endereço', with: 'Rua Nova, N: 200'
    fill_in 'E-mail', with: 'sac@codeplay.com.br'
    click_on 'Registrar Empresa'

    expect(page).to have_text('Empresa cadastrada com sucesso')
    expect(page).to have_text('Perfil CodePlay')
    expect(page).to have_text('CNPJ')
    expect(page).to have_text('12345678902')
    expect(page).to have_text('Endereço')
    expect(page).to have_text('Rua Nova, N: 200')
    expect(page).to have_text('E-mail')
    expect(page).to have_text('sac@codeplay.com.br')
    expect(page).to have_text('Status')
    expect(page).to have_text('Empresa habilitada')
  end

  it 'and attributes cannot be blank' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)

    login_as admin_client, scope: 'client'
    visit new_admin_client_company_path
    click_on 'Registrar Empresa'

    expect(page).to have_content("Cnpj can't be blank")
    # expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content("Corporate name can't be blank")
    # expect(page).to have_content('Razão social não pode ficar em branco')
    expect(page).to have_content("Address can't be blank")
    # expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content("Email can't be blank")
    # expect(page).to have_content('E-mail não pode ficar em branco')
  end

  it 'and corporate name must be unique' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
    Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902',
                    address: 'Rua Nova, N: 200', email: 'sac@codeplay.com.br',
                    client_id: admin_client.id)


    login_as admin_client, scope: 'client'
    visit new_admin_client_company_path
    fill_in 'Razão Social', with: 'CodePlay'
    fill_in 'CNPJ', with: '12345678933'
    fill_in 'Endereço', with: 'Rua Velha, N: 300'
    fill_in 'E-mail', with: 'sac@codeplay.com.br'
    click_on 'Registrar Empresa'
    
    #expect(page).to have_content('Razão social já está em uso')
    expect(page).to have_content('Corporate name has already been taken')
  end

  it 'must be admin_client to edit companies' do
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 0)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902',
                              address: 'Rua Nova, N: 200', email: 'sac@codeplay.com.br',
                              client_id: admin_client.id)
    
    login_as admin_client, scope: 'client'
    visit new_admin_client_company_path

    expect(page).to have_content('Acesso apenas pelo Administrador')
  end
end
