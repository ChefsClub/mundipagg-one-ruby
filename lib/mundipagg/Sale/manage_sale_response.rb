class ManageSaleResponse
  # Cole��o de transa��es de cart�o de cr�dito
  attr_accessor :CreditCardTransactionResultCollection

  def initialize
    @CreditCardTransactionResultCollection = Array.new
  end
end