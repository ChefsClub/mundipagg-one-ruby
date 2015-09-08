require_relative 'person'

class Buyer < Person
  # Chave do comprador. Utilizada para identificar um comprador no gateway
  attr_accessor :BuyerKey

  # Refer�ncia do comprador no sistema da loja
  attr_accessor :BuyerReference

  # Lista de endere�os do comprador
  attr_accessor :AddressCollection

  # Data de cria��o do comprador no sistema da loja
  attr_accessor :CreateDateInMerchant

  # Data da �ltima atualiza��o do cadastro do comprador no sistema da loja
  attr_accessor :LastBuyerUpdateInMerchant

  # Categoria do comprador
  attr_accessor :BuyerCategory

  @@BuyerCategoryEnum = {
      :Normal => '1',
      :Plus => '1'
  }

  def initialize
    @AddressCollection = Array.new
  end

  def self.BuyerCategory
    @@BuyerCategoryEnum
  end
end