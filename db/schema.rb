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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140211153646) do

  create_table "banners", force: true do |t|
    t.string   "pic"
    t.string   "link"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "cart_id"
    t.integer  "product_color_id"
    t.integer  "product_size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["product_color_id"], name: "index_cart_items_on_product_color_id", using: :btree
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree
  add_index "cart_items", ["product_size_id"], name: "index_cart_items_on_product_size_id", using: :btree

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", force: true do |t|
    t.text     "context"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "purpose"
  end

  add_index "faqs", ["purpose"], name: "index_faqs_on_purpose", using: :btree

  create_table "news", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "pic"
    t.integer  "sort"
    t.integer  "sort_en"
    t.boolean  "is_tw"
    t.boolean  "is_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "release_date"
  end

  add_index "news", ["release_date"], name: "index_news_on_release_date", using: :btree

  create_table "news_tags", force: true do |t|
    t.string "name"
    t.string "name_en"
  end

  create_table "news_tags_relations", force: true do |t|
    t.integer "news_id"
    t.integer "news_tag_id"
  end

  create_table "order_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.integer  "price"
    t.integer  "product_size_id"
    t.integer  "product_color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "shipping_address"
    t.string   "billing_address"
    t.string   "receiver"
    t.string   "phone"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "user_id"
    t.integer  "shipping_cost_id"
    t.string   "shipping_name"
    t.string   "shipping_store"
    t.integer  "total"
    t.text     "memo"
    t.string   "payment"
    t.string   "bank"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_payed",         default: false
    t.string   "code"
    t.boolean  "is_show"
  end

  add_index "orders", ["shipping_cost_id"], name: "index_orders_on_shipping_cost_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "product_categories", force: true do |t|
    t.string   "name"
    t.boolean  "is_visible", default: true
    t.integer  "parent_id"
    t.integer  "sort"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_categories", ["parent_id"], name: "index_product_categories_on_parent_id", using: :btree

  create_table "product_colors", force: true do |t|
    t.integer  "product_id"
    t.string   "color"
    t.string   "color_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_delete",  default: false
  end

  add_index "product_colors", ["product_id"], name: "index_product_colors_on_product_id", using: :btree

  create_table "product_infos", force: true do |t|
    t.string   "name"
    t.string   "weight"
    t.string   "material"
    t.string   "capacity"
    t.text     "quick_overview"
    t.string   "dimension"
    t.integer  "price"
    t.integer  "special_price"
    t.text     "feature"
    t.boolean  "is_visible",     default: false
    t.integer  "product_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shipping"
  end

  add_index "product_infos", ["country_id"], name: "index_product_infos_on_country_id", using: :btree
  add_index "product_infos", ["product_id"], name: "index_product_infos_on_product_id", using: :btree

  create_table "product_pics", force: true do |t|
    t.integer  "product_id"
    t.string   "description"
    t.string   "pic"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_pics", ["product_id"], name: "index_product_pics_on_product_id", using: :btree

  create_table "product_quantities", force: true do |t|
    t.integer  "product_id"
    t.integer  "product_color_id"
    t.integer  "product_size_id"
    t.integer  "quantity",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_quantities", ["product_color_id"], name: "index_product_quantities_on_product_color_id", using: :btree
  add_index "product_quantities", ["product_id"], name: "index_product_quantities_on_product_id", using: :btree
  add_index "product_quantities", ["product_size_id"], name: "index_product_quantities_on_product_size_id", using: :btree

  create_table "product_sizes", force: true do |t|
    t.integer  "product_id"
    t.string   "size"
    t.string   "size_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_delete",  default: false
  end

  add_index "product_sizes", ["product_id"], name: "index_product_sizes_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "no"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort",                default: 0
    t.integer  "views",               default: 0
    t.boolean  "is_show_at_index",    default: false
    t.string   "slug"
  end

  add_index "products", ["product_category_id"], name: "index_products_on_product_category_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", using: :btree
  add_index "products", ["sort"], name: "index_products_on_sort", using: :btree
  add_index "products", ["views"], name: "index_products_on_views", using: :btree

  create_table "shipping_costs", force: true do |t|
    t.integer  "cost"
    t.string   "description"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipping_costs", ["country_id"], name: "index_shipping_costs_on_country_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "shipping_address"
    t.string   "billing_address"
    t.string   "receiver"
    t.string   "phone"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "avatar"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "token"
  end

  create_table "videos", force: true do |t|
    t.string   "link"
    t.text     "intro"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
