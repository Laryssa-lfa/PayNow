
# PayNow
Projeto final da etapa 01 do Treina Dev - Turma 06. Esse projeto visa construir uma ferramenta fictícia de pagamentos com o minímo produto viável (MVP) em Ruby on Rails.


## Dependências do Sistema
 * Ruby versão 3.0.0
 * Rails versão 6.1.3.2 
 * Banco de dados SQLite


## Gems Utilizadas
 - [Rspec](https://relishapp.com/rspec/rspec-rails/v/5-0/docs/gettingstarted) - para teste
 - [Capybara](https://rubydoc.info/github/teamcapybara/capybara) - para teste
 - [Devise](https://github.com/heartcombo/devise) - para autenticação
 - [Bootstrap](https://getbootstrap.com/) - para font-end


## Replicando o projeto

Para clonar o projeto

```bash
  git clone https://github.com/Laryssa-lfa/PayNow
```

Vá até o diretório do projeto

```bash
  cd PayNow
```

Instale as dependências

```bash
  rails bin/setup
```

Inicializar o servidor

```bash
  rails server
```


## API Referências

No projeto existem três API's, uma para gerar *token* do cliente final, uma para geraras cobranças e uma para consultar as cobranças.


#### API para Clientes Finais
Apenas registra os dados do cliente final

```http
  POST /api/v1/end_clients
```

| Parâmetros | Tipo     | Descrição                |
| :-------- | :------- | :------------------------- |
| `name` | `string` | **Obrigatório**. Nome completo do client |
| `cpf` | `integer` | **Obrigatório**. CPF do client com apenas números; contém 11 números |
| `company_token` | `string` | **Obrigatório**. *token* de identificação da empresa que o cliente está vinculado |


#### API para Gerar Cobranças
Criando os dados

```http
  POST /api/v1/billing_issues
```

| Parâmetros | Tipo     | Descrição                       |
| :-------- | :------- | :-------------------------------- |
| `company_token` | `string` | **Obrigatório**. *token* de identificação da empresa que solicita a cobrança |
| `product_token` | `string` | **Obrigatório**. *token* de identificação do produto vendido pela empresa |
| `end_client_token` | `string` | **Obrigatório**. *token* de identificação do cliente final que realizou a cobrança |
| `type_payment` | `string` | **Automático**. Meio de pagamento utilizado; vinculado a identificação do produto |
| `card_number` | `string` | **Pode ser Obrigatório**. Número do cartão de cédito; usado quando escolhido 'Cartão de Crédito' como meio de pagamento |
| `name_client_card` | `string` | **Pode ser Obrigatório**. Nome impresso no cartão de cédito; usado quando escolhido 'Cartão de Crédito' como meio de pagamento |
| `verification_code` | `string` | **Pode ser Obrigatório**. Código de verificação do cartão de cédito; usado quando escolhido 'Cartão de Crédito' como meio de pagamento |
| `full_address` | `string` | **Pode ser Obrigatório**. Endereço completo para pagamento; usado quando escolhido 'Boleto Bancário' como meio de pagamento |
| `price_product` | `string` | **Automático**. Valor do produto vendido; vinculado a identificação do produto |
| `price_discount` | `string` | **Automático**. Valor do produto vendido aplicado um desconto; vinculado a identificação do produto |


Consultando uma cobrança

```http
  GET /api/v1/billing_issues/#{token}
```

| Parâmetros | Tipo     | Descrição                       |
| :-------- | :------- | :-------------------------------- |
| `token` | `string` | **Obrigatório**. *token* de identificação da cobrança |


#### API para Consultar Cobranças
Em desenvolvimento


**OBS.: Projeto em desenvolvimento**
