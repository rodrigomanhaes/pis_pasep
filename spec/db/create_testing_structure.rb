class CreateTestingStructure < ActiveRecord::Migration
  def self.up
    create_table :funcionarios do |t|
      t.string :nome
      t.string :pis_pasep
    end
  end

  def self.down
    drop_table :funcionarios
  end
end

