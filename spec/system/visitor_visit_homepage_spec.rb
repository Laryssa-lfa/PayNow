require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'PayNow')
    expect(page).to have_css('h3', text: 'Sistema de gestão de pagamentos')
    expect(page).to have_css('img[src="#{Rails.root}.join(app/assets/images/icon-Logotipo.png)"]')
    expect(page).to have_link('Área Administrativa')
    expect(page).to have_link('Registrar')
    expect(page).to have_link('Entrar')
    expect(page).to_not have_link('Gerenciar Funcionários')
    expect(page).to_not have_link('Gerenciar Clientes')
    expect(page).to_not have_link('Gerenciar Meios de Pagamento')
  end
end
