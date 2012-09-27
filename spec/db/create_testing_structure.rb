class CreateTestingStructure < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :name
      t.string :pasep
    end
  end

  def self.down
    drop_table :employees
  end
end
