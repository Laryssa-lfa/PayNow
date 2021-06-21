require 'rails_helper'

describe 'Account Management' do
  context 'sign in' do
    it 'with email and password' do
      Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'maria@codeplay.com.br'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      #expect(page).to have_text('Login efetuado com sucesso!')
      expect(page).to have_text('Signed in successfully')
      expect(page).to have_text('maria@codeplay.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Entrar')
      expect(page).to_not have_link('Registrar')
      expect(page).to have_link('Sair')
    end

    it 'without valid field' do
      Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'maria@gmail.com'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      #expect(page).to have_text('Email inválido')
      expect(page).to have_text('Invalid Email or password.')
      expect(current_path).to eq(client_session_path)
    end

    it 'without being registered' do

      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'maria@codeplay.com.br'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      #expect(page).to have_text('Email inválido')
      expect(page).to have_text('Invalid Email or password.')
      expect(current_path).to eq(client_session_path)
    end
  end

  context 'logout' do
    it 'successfully' do
      admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br', password: '123456')

      login_as admin_client, scope: 'client'
      visit root_path
      click_on 'Sair'

      #expect(page).to have_text('Saiu com sucesso')
      expect(page).to have_text('Signed out successfully')
      expect(page).to_not have_text('maria@codeplay.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Entrar')
      expect(page).to have_link('Registrar')
      expect(page).to have_link('Área Administrativa')
      expect(page).to_not have_link('Sair')
    end
  end
end
