require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'PayNow')
    expect(page).to have_css('h3', text: 'Sistema de gestão de pagamentos')
    #expect(page).to have_css('img[src="app/assets/images/icon-Logotipo.png"]')
    expect(page).to have_link('Área Administrativa')
    expect(page).to have_link('Registrar')
    expect(page).to have_link('Entrar')
  end
end
