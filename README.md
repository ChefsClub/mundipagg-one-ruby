# mundipagg-one-ruby

### About Windows
The recommended Windows version of Ruby is Ruby 2.1.
For gems work correctly it'll be necessary run the following commands:

No Windows a vers�o do Ruby recomendada � a 2.1.
Para que todas as gemas funcionem corretamente � necess�rio realizar o seguinte processo:
- gem install rubygems-update
- update_rubygems
- gem update --system

### Required Gems
- gem install rest-client
- gem install rspec
- gem install nori
- gem install gyoku
- gem install nokogiri
- gem install ffi

### Bundler (not supported yet)
- gem install bundler

## Code Examples

### Create a Credit Card Transaction
```ruby
require_relative '../../lib/mundipagg'

# passa a merchantKey na vari�vel
merchantKey = 'sua merchantKey'

# instancia classe com m�todos de requisi��o
# :staging ou nada para ambiente sandbox e :production para ambiente de produ��o
gateway = Gateway.new(:production, merchantKey)

# coleta dados do cart�o
creditCardTransaction = CreditCardTransaction.new
creditCardTransaction.AmountInCents = 100
creditCardTransaction.InstallmentCount = 1
creditCardTransaction.TransactionReference = 'CreditCard One RubySDK Test'
creditCardTransaction.Options.PaymentMethodCode = 1
creditCardTransaction.Options.SoftDescriptorText = 'My Store Name'
creditCardTransaction.CreditCard.CreditCardNumber = '5453010000066167'
creditCardTransaction.CreditCard.ExpMonth = 5
creditCardTransaction.CreditCard.ExpYear = 18
creditCardTransaction.CreditCard.HolderName = 'Maria do Carmo'
creditCardTransaction.CreditCard.SecurityCode = '123'
creditCardTransaction.CreditCard.CreditCardBrand = 'Mastercard'

# cria a transa��o
createSaleRequest = CreateSaleRequest.new
createSaleRequest.CreditCardTransactionCollection << creditCardTransaction

# faz a requisi��o de cria��o de transa��o, retorna um hash com a resposta
response = gateway.CreateSale(createSaleRequest)
```


### Create a BoletoTransaction
```ruby
require_relative '../../lib/mundipagg'

# passa a merchantKey na vari�vel
merchantKey = 'sua merchantKey'

# instancia classe com m�todos de requisi��o
# :staging ou nada para ambiente sandbox e :production para ambiente de produ��o
gateway = Gateway.new(:production, merchantKey)

# instancia um objeto de transa��o de boleto
boletoTransaction = BoletoTransaction.new
boletoTransaction.AmountInCents = 100
boletoTransaction.BankNumber = '237'
boletoTransaction.DocumentNumber = '12345678901'
boletoTransaction.Instructions = 'Pagar antes do vencimento'
boletoTransaction.TransactionReference = 'BoletoTest#Ruby01'
boletoTransaction.Options.CurrencyIso = 'BRL'
boletoTransaction.Options.DaysToAddInBoletoExpirationDate = 5

# instancia um objeto de request para fazer a cria��o de transa��o
createSaleRequest = CreateSaleRequest.new

# incrementa na cole��o de boletos a transa��o de boleto criada
createSaleRequest.BoletoTransactionCollection << boletoTransaction

# faz a requisi��o de cria��o de transa��o, retorna um hash com a resposta
response = gateway.CreateSale(createSaleRequest)
```


### Cancel Method
```ruby
require_relative '../../lib/mundipagg'

merchantKey = 'Sua Merchant Key'

# instancia classe com m�todos de requisi��o
# :staging para ambiente sandbox e :production para ambiente de produ��o
gateway = Gateway.new(:staging, merchantKey)

# preenche um item de colecao, necessario para cancelamento da transacao de cartao de credito
cancelCreditCardTransactionItem = ManageCreditCardTransaction.new
cancelCreditCardTransactionItem.AmountInCents = 100
cancelCreditCardTransactionItem.TransactionKey = 'TransactionKey da transa��o'
cancelCreditCardTransactionItem.TransactionReference = 'RubySDK-CancelTest'

# monta o objeto para cancelamento de transa��o
cancelSaleRequest = ManageSaleRequest.new
cancelSaleRequest.OrderKey = 'OrderKey AQUI'
cancelSaleRequest.CreditCardTransactionCollection << cancelCreditCardTransactionItem

# incrementa na cole��o o item de retry
retrySaleRequest.RetrySaleCreditCardTransactionCollection << retrySaleCreditCardTransactionItem

# faz a requisi��o de cancelamento, retorna um hash com a resposta
response = gateway.Cancel(cancelSaleRequest)
```


### Capture Method
```ruby
require_relative '../../lib/mundipagg'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com m�todos de requisi��o
# :staging ou nada para ambiente de sandbox e :production para ambiente de produ��o
gateway = Gateway.new(merchantKey)

# itens necess�rios para captura da transac�o
captureCreditCardTransactionItem = ManageCreditCardTransaction.new
captureCreditCardTransactionItem.AmountInCents = 100
captureCreditCardTransactionItem.TransactionKey = 'transactionKey da transa��o'
captureCreditCardTransactionItem.TransactionReference = 'RubySDK-CaptureTest (refer�ncia da transa��o)'

# monta o objeto para captura de transa��o
captureSaleRequest = ManageSaleRequest.new
captureSaleRequest.OrderKey = 'orderkey da transa��o'

# incrementa na cole��o de CreditCardTransactionCollection
captureSaleRequest.CreditCardTransactionCollection << captureCreditCardTransactionItem

# faz a requisi��o de captura e salva na vari�vel response
response = gateway.Capture(captureSaleRequest)
```


### Retry Method
```ruby
require_relative '../../lib/mundipagg'

merchantKey = 'Sua Merchant Key'

# instancia classe com m�todos de requisi��o
# :staging para ambiente sandbox e :production para ambiente de produ��o
gateway = Gateway.new(:staging, merchantKey)

retrySaleRequest = RetrySaleRequest.new
retrySaleCreditCardTransactionItem = RetrySaleCreditCardTransaction.new

# preenche um item de cole��o
retrySaleCreditCardTransactionItem.SecurityCode = '123'
retrySaleCreditCardTransactionItem.TransactionKey = 'Transaction Key AQUI'

# monta o objeto de retentativa
retrySaleRequest.OrderKey = 'OrderKey AQUI'

# incrementa na cole��o o item de retry
retrySaleRequest.RetrySaleCreditCardTransactionCollection << retrySaleCreditCardTransactionItem

# faz a requisi��o de retentativa, retorna um hash com a resposta
response = gateway.Retry(retrySaleRequest)
```


### Query Method
```ruby
require_relative '../../lib/mundipagg'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com m�todos de requisi��o
# :staging ou nada para ambiente de sandbox e :production para ambiente de produ��o
gateway = Gateway.new(merchantKey)

# inicializa a QuerySaleRequest
querySaleRequest = QuerySaleRequest.new

# preenche o campo de OrderKey para enviar um request de OrderKey
querySaleRequest.OrderKey = 'sua OrderKey'

# faz a requisi��o de Query passando QuerySaleRequest.QuerySaleRequestEnum[:OrderKey] para indicar
# que o m�todo ir� procurar por OrderKey e passa a OrderKey como segundo par�metro
# retorna um hash com a resposta
responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderKey], querySaleRequest.OrderKey)

# se a requisi��o for por OrderReference ela � bem parecida com a de cima, mudando apenas algumas coisas:
querySaleRequest.OrderReference = 'sua OrderReference'

responseQuery = gateway.Query(QuerySaleRequest.QuerySaleRequestEnum[:OrderReference], querySaleRequest.OrderReference)
```


### ParseXmlToNotification
The ParseXmlToNotification takes an XML and convert it to a hash variable.

```ruby
require_relative '../../lib/mundipagg'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com m�todos de requisi��o
# :staging ou nada para ambiente de sandbox e :production para ambiente de produ��o
gateway = Gateway.new(merchantKey)

xml = 'xml que ser� passsado na vari�vel'

# faz a requisi��o de PostNotification (parse do XML) e retorna um hash do XML passado
response = gateway.ParseXmlToNotification(xml)
```


### TransactionReportFile Method
```ruby
require_relative '../../lib/mundipagg'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com m�todos de requisi��o
# :staging ou nada para ambiente de sandbox e :production para ambiente de produ��o
gateway = Gateway.new(merchantKey)

# cria uma vari�vel do tipo Date, passando apenas o ano, m�s e dia (nessa ordem)
date = Date.new(2014, 12, 10)

# faz a requisi��o do TransactionReportFile e retorna uma string com os dados do report
response = gateway.TransactionReportFile(date)
```


##### TransactionReportFileParser
If you want the string that is received from TransactionReportFile Method to be parsed, there is a method for that.
```ruby
require_relative '../../lib/mundipagg'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com m�todos de requisi��o
# :staging ou nada para ambiente de sandbox e :production para ambiente de produ��o
gateway = Gateway.new(merchantKey)

# cria uma vari�vel do tipo Date, passando apenas o ano, m�s e dia (nessa ordem)
date = Date.new(2014, 12, 10)

# faz a requisi��o do TransactionReportFile e retorna uma string com os dados do report
request_to_parse = gateway.TransactionReportFile(date)

# faz um parse da string do TransactionReportFile e retorna um hash com a resposta
response = gateway.TransactionReportFileParser(request_to_parse)
```

##### TransactionReportFileDownloader
This method download and save the TransactionReportFile to a '.txt' file.
```ruby
require_relative '../../lib/mundipagg'

# merchant key 
merchantKey = 'sua merchantKey'

# inicializa a classe com m�todos de requisi��o
# :staging ou nada para ambiente de sandbox e :production para ambiente de produ��o
gateway = Gateway.new(merchantKey)

# cria uma vari�vel do tipo Date, passando apenas o ano, m�s e dia (nessa ordem)
date = Date.new(2015, 9, 15)

# faz a requisi��o do transaction report file e salva no destino passado como par�metro
# o segundo par�metro � o nome do arquivo, e o terceiro � o local onde ser� salvo o arquivo
# � salvo um arquivo em .txt no local indicado
response = gateway.TransactionReportFileDownloader(date, 'Teste', "C:\\Users\\YourUser\\Desktop\\")
```