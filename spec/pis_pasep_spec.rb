require File.dirname(__FILE__) + '/spec_helper'

describe PisPasep do
  it 'accepts a valid number' do
    validos = %w(12345678919 34608514300 47393545608)
    validos.each {|n| PisPasep.new(n).should be_valido }
  end

  it 'does not validate with invalid characters' do
    numeros = %w(1111111a111 111s1111111 r111111111 1111111111w)
    numeros.each.each {|n| PisPasep.new(n).should_not be_valido }
  end

  it 'validates a nil number' do
    PisPasep.new(nil).should be_valido
  end

  it 'does not validate with less digits than allowed' do
    PisPasep.new('1234567891').should_not be_valido
  end

  it 'does not validate with more digits than allowed' do
    PisPasep.new('123456789191').should_not be_valido
  end

  it 'does not validate with first check digit wrong' do
    # valid = 248.438.034-80
    PisPasep.new('24843803470').should_not be_valido
  end

  it 'does not validate with second check digit wrong' do
    # valid = 099.075.865-60
    PisPasep.new('09907586561').should_not be_valido
  end

  it 'accepts a formatted valid number' do
    PisPasep.new('123.45678.91-9').should be_valido
  end

  it 'does not validate a valid number with incorrect format' do
    # valid = 123.45678.91-9
    PisPasep.new('123.4567.891-9').should_not be_valido
  end

  it 'returns formatted NIT number' do
    PisPasep.new('12345678919').to_s.should == '123.45678.91-9'
  end

  it 'formats the number at instantiation' do
    PisPasep.new('12345678919').numero.should == '123.45678.91-9'
  end

  it 'equals to another pis/pasep with same number' do
    PisPasep.new('12345678919').should == PisPasep.new('123.45678.91-9')
  end
end
