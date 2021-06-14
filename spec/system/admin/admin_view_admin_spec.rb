require 'rails_helper'

describe 'Admin view other admins' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Desenvolvedor', password: '654321')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Funcionários'

    expect(current_path).to eq(admins_path)
    expect(page).to have_link('Registrar Funcionários', href: new_admin_path)
    expect(page).to have_link('Jane', href: admin_path(admin))
    expect(page).to have_link('Paulo', href: admin_path(funcionario))
  end

  it 'and view details' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Desenvolvedor', password: '654321')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Funcionários'
    click_on 'Paulo'

    expect(current_path).to eq(admin_path(funcionario))
    expect(page).to have_content(funcionario.name)
    expect(page).to have_content(funcionario.email)
    expect(page).to have_content(funcionario.occupation)
    expect(page).to have_link('Editar')
    expect(page).to have_link('Apagar')
    expect(page).to have_link('Voltar')
  end

  it 'and return to home page' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Desenvolvedor', password: '654321')

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Gerenciar Funcionários'
    click_on 'Paulo'
    click_on 'PayNow'

    expect(current_path).to eq root_path
    expect(page).to have_content(admin.name)
    expect(page).to have_link('Gerenciar Funcionários')
    expect(page).to have_link('Gerenciar Clientes')
    expect(page).to have_link('Gerenciar Meios de Pagamento')
  end
end
