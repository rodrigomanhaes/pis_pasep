require File.dirname(__FILE__) + '/spec_helper'

describe PisPasep::Base do
  it 'accepts a valid number' do
    validos = %w(12345678919 34608514300 47393545608)
    validos.each {|n| PisPasep::Base.new(n).should be_valid }
  end

  it 'does not validate with invalid characters' do
    numbers = %w(1111111a111 111s1111111 r111111111 1111111111w)
    numbers.each.each {|n| PisPasep::Base.new(n).should_not be_valid }
  end

  it 'validates a nil number' do
    PisPasep::Base.new(nil).should be_valid
  end

  it 'does not validate with less digits than allowed' do
    PisPasep::Base.new('1234567891').should_not be_valid
  end

  it 'does not validate with more digits than allowed' do
    PisPasep::Base.new('123456789191').should_not be_valid
  end

  it 'does not validate with first check digit wrong' do
    # valid = 248.438.034-80
    PisPasep::Base.new('24843803470').should_not be_valid
  end

  it 'does not validate with second check digit wrong' do
    # valid = 099.075.865-60
    PisPasep::Base.new('09907586561').should_not be_valid
  end

  it 'accepts a formatted valid number' do
    PisPasep::Base.new('123.45678.91-9').should be_valid
  end

  it 'does not validate a valid number with incorrect format' do
    # valid = 123.45678.91-9
    PisPasep::Base.new('123.4567.891-9').should_not be_valid
  end

  it 'returns formatted NIT number' do
    PisPasep::Base.new('12345678919').to_s.should == '123.45678.91-9'
  end

  it 'formats the number at instantiation' do
    PisPasep::Base.new('12345678919').number.should == '123.45678.91-9'
  end

  it 'equals to another pis/pasep with same number' do
    PisPasep::Base.new('12345678919').should == PisPasep::Base.new('123.45678.91-9')
  end
end
