require 'rails_helper'

describe 'Account Management' do
  context 'sign in' do
    it 'with email and password' do
      Admin.create!(name: 'Jane', email: 'jane@paynow.com.br', password: '123456')

      visit root_path
      click_on 'Área Administrativa'
      fill_in 'E-mail', with: 'jane@paynow.com.br'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      #expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('Signed in successfully')
      expect(page).to have_text('Jane')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Área Administrativa')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      Admin.create!(email: 'jane@paynow.com.br', password: '123456')

      visit root_path
      click_on 'Área Administrativa'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      #expect(page).to have_text('Email ou senha inválida.')
      expect(page).to have_text('Invalid Email or password')
      expect(current_path).to eq(admin_session_path)
    end
  end

  context 'logout' do
    it 'successfully' do
      admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br', password: '123456')

      login_as admin, scope: 'admin'
      visit root_path
      click_on 'Sair'

      #expect(page).to have_text('Saiu com sucesso')
      expect(page).to have_text('Signed out successfully')
      expect(page).to_not have_text('Jane')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Entrar')
      expect(page).to have_link('Registrar')
      expect(page).to have_link('Área Administrativa')
      expect(page).to_not have_link('Sair')
    end
  end
end
