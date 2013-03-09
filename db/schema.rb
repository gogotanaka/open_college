# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130309112112) do

  create_table "class_grades", :force => true do |t|
    t.integer  "user_id"
    t.integer  "class_room_id"
    t.string   "grade"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "class_grades", ["user_id", "class_room_id"], :name => "index_class_grades_on_user_id_and_class_room_id"

  create_table "class_rooms", :force => true do |t|
    t.string   "name"
    t.string   "term"
    t.datetime "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relation_class_room_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "class_room_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "relation_class_room_users", ["user_id", "class_room_id"], :name => "index_relation_class_room_users_on_user_id_and_class_room_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
