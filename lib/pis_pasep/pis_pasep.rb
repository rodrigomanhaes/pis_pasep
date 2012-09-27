module PisPasep
  class Base
    attr_reader :number

    def initialize(number)
      @number = number
      @number = @number =~ PIS_PASEP_REGEX ? format_number! : @number
    end

    def valid?
      return true if @number.nil?
      return false unless format_valid?
      number_valid?
    end

    def to_s
      number
    end

    def ==(outro)
      self.number == outro.number
    end

    private

    DIGITS = 11
    PIS_PASEP_REGEX = /^(\d{3})\.?(\d{5})\.?(\d{2})\-?(\d{1})$/

    def format_valid?
      return false unless @number =~ PIS_PASEP_REGEX
      @number.gsub(/[^0-9]*/, "").size == DIGITS
    end

    def number_valid?
      num = @number.gsub(/[^0-9]*/, "")
      dv = num[-1].to_i
      sum = 0
      coefficient = 2
      (num.size - 2).downto(0) do |i|
        digit = num[i].to_i
        sum += digit * coefficient
        coefficient += 1
        coefficient = 2 if coefficient > 9
      end
      found_checksum = 11 - sum % 11
      found_checksum = 0 if found_checksum >= 10
      found_checksum == dv
    end

    def format_number!
      @number =~ PIS_PASEP_REGEX
      @number = "#{$1}.#{$2}.#{$3}-#{$4}"
    end
  end
end
