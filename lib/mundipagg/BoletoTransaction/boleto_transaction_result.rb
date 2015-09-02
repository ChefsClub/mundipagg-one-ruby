class BoletoTransactionResult
  # Url para visualiza��o do boleto
  attr_accessor :BoletoUrl

  # C�digo de barras
  attr_accessor :Barcode

  # Status do boleto
  attr_accessor :BoletoTransactionStatus

  @@BoletoTransactionStatusEnum = {
      # Gerado
      :Generated => '1',

      # Visualizado
      :Viewed => '2',

      # Pago com valor abaixo
      :Underpaid => '3',

      # Pago com valor maior
      :Overpaid => '4',

      # Pago
      :Paid => '5',

      # Cancelado
      :Voided => '6',

      # Com erro
      :WithError => '99'
  }

  # Chave da transa��o. Utilizada para identificar a transa��o de boleto no gateway
  attr_accessor :TransactionKey

  # Valor original da transa��o em centavos
  attr_accessor :AmountInCents

  # N�mero do documento
  attr_accessor :DocumentNumber

  # Identificador da transa��o no sistema da loja
  attr_accessor :TransactionReference

  # Indica se houve sucesso na gera��o do boleto
  attr_accessor :Success

  # N�mero de identifica��o do boleto
  attr_accessor :NossoNumero

  def initialize
    @BoletoTransactionStatus = self.BoletoTransactionStatusEnum
  end
end