require File.dirname(__FILE__) + '/spec_helper'

class Employee < ActiveRecord::Base
  use_as_pis_pasep :pasep
end

describe "Using a model attribute as PIS/PASEP number" do
  let(:employee) { Employee.new }

  it "formats the received number" do
    employee.pasep = "12345678919"
    employee.pasep.number.should == "123.45678.91-9"
  end

  it 'responds to pis_pasep_valid?' do
    employee.pasep = "12345678919"
    employee.should respond_to(:pasep_valid?)
  end

  it "makes model invalid if pis/pasep is invalid" do
    employee.pasep = "123545"
    employee.should_not be_valid
  end

  it "doesn't save the model with an invalid number" do
    employee.pasep = "sdwewe"
    employee.save.should be_false
  end

  it "generates an error in the pis_pasep field when invalid" do
    employee.pasep = "232df"
    employee.save
    employee.errors[:pasep].should be_any
  end

  it "validates model with a null pis_pasep" do
    employee.pasep = nil
    employee.should be_valid
  end

  it 'accepts an empty string in the constructor of an instance of pis/pasep' do
    employee.pasep = PisPasep::Base.new("")
    employee.should be_valid
  end

  it "accepts an empty string as the pis/pasep number" do
    employee.pasep = ""
    employee.should be_valid
  end

  it "accepts an instance of PisPasep" do
    employee.pasep = PisPasep::Base.new("12345678919")
    employee.pasep.should be_an_instance_of(PisPasep::Base)
  end

  it "is able to receive parameters at initialization" do
    employee = Employee.new(:pasep => "12345678919")
    employee.pasep.number.should == "123.45678.91-9"
  end

  context 'validation' do
    before :each do
      Employee.validates_presence_of :pasep
    end

    describe 'presence' do
      it 'is invalid with a new pis/pasep number' do
        employee.should_not be_valid
        employee.errors[:pasep].should be_any
      end

      it "is invalid using an empty string as the pis/pasep number" do
        employee = Employee.new(:pasep => "")
        employee.should_not be_valid
        employee.errors[:pasep].should be_any
      end

      it 'is valid with a healthy pis/pasep' do
        Employee.new(:pasep => '123.45678.91-9').should be_valid
        Employee.new(:pasep => '12345678919').should be_valid
      end
    end

    describe "uniqueness" do
      before(:each) do
        Employee.validates_uniqueness_of :pasep
        f = Employee.new(:pasep => "12345678919")
        f.save
      end

      it "is invalid if the same value already exists" do
        employee = Employee.new(:pasep => "12345678919")
        employee.should_not be_valid
        employee.errors[:pasep].should be_any
      end

      it "is valid if the value is new" do
        employee = Employee.new(:pasep => "47393545608")
        employee.should be_valid
      end
    end
  end
end
