class PisPasep
  def initialize(numero)
    @numero = numero
  end

  def valido?
    return true if @numero.nil?
    return false unless formato_valido?
    numero_valido?
  end

  def to_s

  end

  private

  DIGITOS = 11
  PIS_PASEP_REGEX = /\d{3}\.\d{5}\.\d{2}\-\d{1}/

  def formato_valido?
    num = @numero.gsub(/[^0-9]*/, "")
    unless @numero =~ PIS_PASEP_REGEX
      return false if @numero != num
    end
    num.size == DIGITOS
  end

  def numero_valido?
    num = @numero.gsub(/[^0-9]*/, "")
    dv = num[-1].to_i
    soma = 0
    coeficiente = 2
    (num.size - 2).downto(0) do |i|
      digit = num[i].to_i
      soma += digit * coeficiente
      coeficiente += 1
      coeficiente = 2 if coeficiente > 9
    end
    dv_encontrado = 11 - soma % 11
    dv_encontrado = 0 if dv_encontrado >= 10
    dv_encontrado == dv
  end
end

