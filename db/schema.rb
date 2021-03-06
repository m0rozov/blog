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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_28_124719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_rates", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.integer "rate", null: false
    t.index ["article_id"], name: "index_article_rates_on_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "text"
    t.inet "ip"
    t.integer "rate_count", default: 0
    t.integer "rate_sum", default: 0
    t.index ["ip"], name: "index_articles_on_ip"
    t.index ["rate_count"], name: "index_articles_on_rate_count"
    t.index ["rate_sum"], name: "index_articles_on_rate_sum"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

end
