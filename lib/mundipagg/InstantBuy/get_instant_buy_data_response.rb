class GetInstantBuyDataResponse
  # Lista de cart�es de cr�dito
  attr_accessor :CreditCardDataCollection

  # Total de cart�es de cr�dito retornados
  attr_accessor :CreditCardDataCount

  def initialize
    @CreditCardDataCollection = Array.new
  end
end