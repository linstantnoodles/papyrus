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

ActiveRecord::Schema.define(version: 20180721232110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.text "front"
    t.text "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "consecutive_correct_answers"
    t.decimal "easiness_factor"
    t.integer "repetition_interval"
    t.datetime "next_due_date"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "test"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.string "stage"
    t.datetime "published_at"
    t.bigint "post_id"
    t.string "slug"
    t.index ["post_id"], name: "index_posts_on_post_id"
    t.index ["slug"], name: "index_posts_on_slug"
  end

  create_table "submissions", force: :cascade do |t|
    t.text "content"
    t.bigint "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_submissions_on_exercise_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.index ["taggable_type", "tag_id", "taggable_id"], name: "tagging_index"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "posts", "posts"
  add_foreign_key "submissions", "exercises"
end
