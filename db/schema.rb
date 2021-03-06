# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_03_080338) do

  create_table "matches", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.integer "opponent_id"
    t.integer "size", default: 10
    t.integer "line", default: 5
    t.integer "result"
    t.text "moves", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "key"
    t.datetime "auth_at"
  end

end
