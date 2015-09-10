class Recurrency
  # Frequ�ncia da recorr�ncia
  attr_accessor :Frequency

  @@FrequencyEnum = {
      :Weekly => '1',
      :Monthly => '2',
      :Yearly => '3',
      :Daily => '4'
  }

  # Intervalo de recorr�ncia
  attr_accessor :Interval

  # Data da primeira cobran�a
  attr_accessor :DateToStartBilling

  # Total de recorr�ncias
  attr_accessor :Recurrences

  # Informa se ser� necess�rio efetuar o procedimento OneDollarAuth antes de registrar a recorr�ncia
  attr_accessor :OneDollarAuth

  def self.Frequency
    @@FrequencyEnum
  end

  def to_json
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    hash
  end

end