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

ActiveRecord::Schema.define(:version => 20130316031325) do

  create_table "class_grades", :force => true do |t|
    t.integer  "user_id"
    t.integer  "class_room_id"
    t.integer  "grade"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "class_grades", ["user_id", "class_room_id"], :name => "index_class_grades_on_user_id_and_class_room_id"

  create_table "class_room_for_years", :force => true do |t|
    t.string   "name"
    t.string   "teacher_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "university_id"
    t.integer  "teacher_id"
  end

  add_index "class_room_for_years", ["name"], :name => "index_class_room_for_years_on_name"
  add_index "class_room_for_years", ["teacher_id"], :name => "index_class_room_for_years_on_teacher_id"
  add_index "class_room_for_years", ["university_id"], :name => "index_class_room_for_years_on_university_id"

  create_table "class_rooms", :force => true do |t|
    t.string   "term"
    t.integer  "year"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "class_room_for_year_id"
  end

  add_index "class_rooms", ["class_room_for_year_id"], :name => "index_class_rooms_on_class_room_for_year_id"

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "university_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "school_subjects", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teachers", ["name"], :name => "index_teachers_on_name"

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "school_year"
    t.string   "play"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "access_token"
    t.integer  "university_id"
    t.integer  "department_id"
    t.integer  "school_subject_id"
  end

  add_index "users", ["access_token"], :name => "index_users_on_access_token"
  add_index "users", ["department_id"], :name => "index_users_on_department_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["school_subject_id"], :name => "index_users_on_school_subject_id"
  add_index "users", ["university_id"], :name => "index_users_on_university_id"

end
