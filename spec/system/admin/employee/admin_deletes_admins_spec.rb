require 'rails_helper'

describe 'Admin deletes admins' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Dev', password: '654321')
    
    login_as admin, scope: 'admin'
    visit employee_admin_path(funcionario)
    expect { click_on 'Apagar' }.to change { Admin.count }.by(-1)

    #expect(page).to have_text('Funcionário(a) apagado com sucesso')
    expect(current_path).to eq(employee_admins_path)
  end

  it 'must be logged in to delete admin' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    funcionario = Admin.create!(name: 'Paulo', email: 'paulo@paynow.com.br',
                                occupation: 'Dev', password: '654321')
    
    visit employee_admin_path(funcionario)

    expect(current_path).to eq(new_admin_session_path)
  end
end
