class AddHitToAttacks < ActiveRecord::Migration
  def self.up
    add_column "attacks", "hit", :boolean
  end

  def self.down
    remove_column "attacks", "hit"
  end
end
