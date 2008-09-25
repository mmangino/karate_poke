class CreateAttacks < ActiveRecord::Migration
  def self.up
    create_table :attacks do |t|
      t.integer :attacking_user_id
      t.integer :defending_user_id
      t.integer :move_id

      t.timestamps
    end
  end

  def self.down
    drop_table :attacks
  end
end
