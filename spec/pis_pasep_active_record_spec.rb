require File.dirname(__FILE__) + '/spec_helper'

class Funcionario < ActiveRecord::Base
  usar_como_pis_pasep :pasep
end

describe "Using a model attribute as PIS/PASEP number" do
  before :each do
    @funcionario = Funcionario.new
  end

  it "formats the received number" do
    @funcionario.pasep = "12345678919"
    @funcionario.pasep.numero.should == "123.45678.91-9"
  end

  it 'responds to pis_pasep_valido?' do
    @funcionario.pasep = "12345678919"
    @funcionario.should respond_to(:pasep_valido?)
  end

  it "makes model invalid if pis/pasep is invalid" do
    @funcionario.pasep = "123545"
    @funcionario.should_not be_valid
  end

  it "doesn't saves the model with an invalid number" do
    @funcionario.pasep = "sdwewe"
    @funcionario.save.should be_false
  end

  it "generates an error in the pis_pasep field when invalid" do
    @funcionario.pasep = "232df"
    @funcionario.save
    @funcionario.errors[:pasep].should be_any
  end

  it "validates model with a null pis_pasep" do
    @funcionario.pasep = nil
    @funcionario.should be_valid
  end

  it 'accepts an empty string in the constructor of an instance of pis/pasep' do
    @funcionario.pasep = PisPasep.new("")
    @funcionario.should be_valid
  end

  it "accepts an empty string as the pis/pasep number" do
    @funcionario.pasep = ""
    @funcionario.should be_valid
  end

  it "accepts an instance of PisPasep" do
    @funcionario.pasep = PisPasep.new("12345678919")
    @funcionario.pasep.should be_an_instance_of(PisPasep)
  end

  it "is able to receive parameters at initialization" do
    @funcionario = Funcionario.new(:pasep => "12345678919")
    @funcionario.pasep.numero.should == "123.45678.91-9"
  end

  context 'validation' do
    before :each do
      Funcionario.validates_presence_of :pasep
    end

    describe 'presence' do
      it 'is invalid with a new pis/pasep number' do
        funcionario = Funcionario.new
        funcionario.should_not be_valid
        funcionario.errors[:pasep].should be_any
      end

      it "is invalid using an empty string as the pis/pasep number" do
        funcionario = Funcionario.new(:pasep => "")
        funcionario.should_not be_valid
        funcionario.errors[:pasep].should be_any
      end

      it 'is valid with a healthy pis/pasep' do
        Funcionario.new(:pasep => '123.45678.91-9').should be_valid
        Funcionario.new(:pasep => '12345678919').should be_valid
      end
    end

    describe "uniqueness" do
      before(:each) do
        Funcionario.validates_uniqueness_of :pasep
        f = Funcionario.new(:pasep => "12345678919")
        f.save
      end

      it "is invalid if the same value already exists" do
        funcionario = Funcionario.new(:pasep => "12345678919")
        funcionario.should_not be_valid
        funcionario.errors[:pasep].should be_any
      end

      it "is valid if the value is new" do
        funcionario = Funcionario.new(:pasep => "47393545608")
        funcionario.should be_valid
      end
    end
  end
end

