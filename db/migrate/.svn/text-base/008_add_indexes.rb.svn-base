class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :attacks, [:attacking_user_id, :created_at]
    add_index :attacks, [:defending_user_id, :created_at]
    add_index :users, :facebook_id
  end

  def self.down
    remove_index :attacks, [:attacking_user_id, :created_at]
    remove_index :attacks, [:defending_user_id, :created_at]
    remove_index :users, :facebook_id
  end
end
