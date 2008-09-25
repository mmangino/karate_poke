class CreateBelts < ActiveRecord::Migration
  def self.up
    create_table :belts do |t|
      t.string :name
      t.integer :level
      t.integer :next_belt_id
      t.integer :minimum_hits

      t.timestamps
    add_column "users", "belt_id", :integer
    add_column "moves", "difficulty_level", :integer
    end
  end

  def self.down
    drop_table :belts
    remove_column "users", "belt_id"
    remove_column "moves", "difficulty_level"
  end
end
