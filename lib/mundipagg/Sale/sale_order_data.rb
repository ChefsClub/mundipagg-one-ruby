class SaleOrderData
  # N�mero do pedido no sistema da loja
  attr_accessor :OrderReference

  # Chave do pedido. Utilizado para identificar o pedido no Gateway
  attr_accessor :OrderKey

  # Data de cria��o do pedido no Gateway
  attr_accessor :CreateDate
end