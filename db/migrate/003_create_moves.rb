class CreateMoves < ActiveRecord::Migration
  def self.up
    create_table :moves do |t|
      t.string :name
      t.string :image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :moves
  end
end
