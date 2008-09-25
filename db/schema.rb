# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 11) do

  create_table "attacks", :force => true do |t|
    t.integer  "attacking_user_id"
    t.integer  "defending_user_id"
    t.integer  "move_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hit"
  end

  add_index "attacks", ["defending_user_id", "created_at"], :name => "index_attacks_on_defending_user_id_and_created_at"
  add_index "attacks", ["attacking_user_id", "created_at"], :name => "index_attacks_on_attacking_user_id_and_created_at"

  create_table "belts", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "next_belt_id"
    t.integer  "minimum_hits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "poster_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "moves", :force => true do |t|
    t.string   "name"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "difficulty_level"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"
  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"

  create_table "users", :force => true do |t|
    t.integer  "facebook_id", :limit => 8, :null => false
    t.string   "session_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "belt_id"
    t.integer  "sensei_id"
    t.integer  "total_hits"
    t.string   "nickname"
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"

end
