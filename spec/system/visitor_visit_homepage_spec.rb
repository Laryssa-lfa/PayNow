require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'PayNow')
    expect(page).to have_css('h3', text: 'Sistema de gestão de pagamentos')
    expect(page).to have_css('img[src="app/assets/images/icon-Logotipo.png"]')
  end
end
