# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_04_011026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "food_prices", id: false, force: :cascade do |t|
    t.date "date"
    t.string "cmname"
    t.string "unit"
    t.string "category"
    t.float "price"
    t.string "currency"
    t.string "country"
    t.string "admname"
    t.integer "adm1id"
    t.string "mktname"
    t.integer "mktid"
    t.integer "cmid"
    t.integer "ptid"
    t.integer "umid"
    t.integer "catid"
    t.string "sn"
    t.string "default"
  end

end
