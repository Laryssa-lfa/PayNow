require 'rails_helper'

describe 'Admin does payment confirmation' do
  it 'successfully' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: admin_client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')
    boleto = Boleto.create!(bank_code: 001, bank_agency: 733, bank_account: 18189, rate: 3,
                            status: true, admin_id: admin.id)
    card = Card.create!(card_name: 'Vix', code: 12345678909876543210, rate: 2, status: true,
                        admin_id: admin.id)
    product = Product.create!(name: 'Ruby', price: '20', type_payment: 'Cartão de Crédito',
                              company_id: company.id)
    product2 = Product.create!(name: 'HTML', price: '50', type_payment: 'Boleto Bancário',
                               discount: '10', company_id: company.id)
    end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                   company_token: company.token)
    billing_issue = 
      BillingIssue.create!(company_token: company.token, product_token: product.token,
                           end_client_token: end_client.token, card_number: '123456789',
                           name_client_card: 'Paulo Pereira', verification_code: '332',
                           type_payment: product.type_payment)
    billing_issue2 = 
      BillingIssue.create!(company_token: company.token, product_token: product2.token,
                           end_client_token: end_client.token, full_address: 'Rua Nova, N: 300',
                           type_payment: product2.type_payment, status: true)

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Confirmar Pagamentos'
    select '05', from: 'Selecione o código referente as opções:'
    fill_in 'Token da cobrança:', with: billing_issue.token
    click_on 'Confirmar'

    expect(current_path).to eq(new_payment_confirmation_path)
    expect(page).to have_content('Confirmação realizada')
    expect(page).to have_content('Cobranças Disponíveis')
    # expect(page).to_not have_content('Token de cobrança:')
    # expect(page).to_not have_content('Status: Pendente')
    # expect(page).to_not have_content('Selecione o código referente as opções:')
    # expect(page).to_not have_content('01 - Pendente de cobrança')
    # expect(page).to_not have_content('05 - Cobrança efetivada com sucesso')
    # expect(page).to_not have_content('09 - Cobrança recusada por falta de créditos')
    # expect(page).to_not have_content('10 - Cobrança recusada por dados incorretos para cobrança')
    # expect(page).to_not have_content('11 - Cobrança recusada sem motivo especificado')
    # expect(page).to_not have_content('Token da cobrança:')
    # expect(page).to_not have_link('Confirmar')
  end

  it 'Admin view payment confirmation history' do
    admin = Admin.create!(name: 'Jane', email: 'jane@paynow.com.br',
                          occupation: 'Gerente', password: '123456')
    admin_client = Client.create!(name: 'Maria', email: 'maria@codeplay.com.br',
                                  password: '123456', role: 1)
    company = Company.create!(corporate_name: 'CodePlay', cnpj: '12345678902', status: true,
                              client_id: admin_client.id, address: 'Rua Nova, N: 200',
                              email: 'sac@codeplay.com.br')
    boleto = Boleto.create!(bank_code: 001, bank_agency: 733, bank_account: 18189, rate: 3,
                            status: true, admin_id: admin.id)
    card = Card.create!(card_name: 'Vix', code: 12345678909876543210, rate: 2, status: true,
                        admin_id: admin.id)
    product = Product.create!(name: 'Ruby', price: '20', type_payment: 'Cartão de Crédito',
                              company_id: company.id)
    product2 = Product.create!(name: 'HTML', price: '50', type_payment: 'Boleto Bancário',
                               discount: '10', company_id: company.id)
    end_client = EndClient.create!(name: 'Paulo Pereira', cpf: 12345678912,
                                   company_token: company.token)
    billing_issue = 
      BillingIssue.create!(company_token: company.token, product_token: product.token,
                           end_client_token: end_client.token, card_number: '123456789',
                           name_client_card: 'Paulo Pereira', verification_code: '332',
                           type_payment: product.type_payment, status: true)
    billing_issue2 = 
      BillingIssue.create!(company_token: company.token, product_token: product2.token,
                           end_client_token: end_client.token, full_address: 'Rua Nova, N: 300',
                           type_payment: product2.type_payment, status: true)
    payment_confirmation = PaymentConfirmation.create!(billing_token: billing_issue.token,
                                                       status_code: '05', payment_date: Date.today)
    payment_confirmation2 = PaymentConfirmation.create!(billing_token: billing_issue2.token,
                                                       status_code: '11', payment_date: Date.today)
                           

    login_as admin, scope: 'admin'
    visit root_path
    click_on 'Histórico dos Pagamentos'

    expect(current_path).to have_content(payment_confirmations_path)
    expect(page).to have_content('Histórico dos Pagamentos')
    expect(page).to have_content('Token da efetivação:', count: 2)
    expect(page).to have_content(payment_confirmation.token)
    expect(page).to have_content('Código do status: 05 - Cobrança efetivada com sucesso')
    expect(page).to have_content('Data da efetivação:', count: 2)
    expect(page).to have_content(payment_confirmation.payment_date)
    expect(page).to have_content('Token da cobrança:', count: 2)
    expect(page).to have_content(payment_confirmation.billing_token)
    expect(page).to have_content(payment_confirmation2.token)
    expect(page).to have_content('Código do status: 11 - Cobrança recusada sem motivo especificado')
    expect(page).to have_content(payment_confirmation2.payment_date)
    expect(page).to have_content(payment_confirmation2.billing_token)
  end
end
