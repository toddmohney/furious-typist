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

ActiveRecord::Schema.define(:version => 20130209100407) do

  create_table "articles", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "body"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

  create_table "articles_categories", :id => false, :force => true do |t|
    t.integer "article_id",  :null => false
    t.integer "category_id", :null => false
  end

  add_index "articles_categories", ["article_id", "category_id"], :name => "index_articles_categories_on_article_id_and_category_id", :unique => true

  create_table "articles_tags", :id => false, :force => true do |t|
    t.integer "article_id", :null => false
    t.integer "tag_id",     :null => false
  end

  add_index "articles_tags", ["article_id", "tag_id"], :name => "index_articles_tags_on_article_id_and_tag_id", :unique => true

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.boolean  "is_email_validated"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_enabled"
    t.boolean  "is_deleted"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
