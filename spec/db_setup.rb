ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Schema.define(version: 20130913054953) do

  create_table "comments", force: true do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"
 
  create_table "catalogs", force: true do |t|
    t.string   "name",          null: false
    t.text     "description"
    t.string   "kind",                        default: "#ffffff"
    t.integer  "parent_id",                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "catalogs", ["name"], name: "index_catalogs_on_name", unique: true

  create_table "likes", force: true do |t|
    t.integer  "user_id",                  null: false
    t.integer  "likable_id",               null: false
    t.string   "likable_type",             null: false
    t.integer  "value",        default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likable_type", "likable_id", "user_id"], name: "index_likes_on_likable_type_and_likable_id_and_user_id", unique: true
  add_index "likes", ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "rates", force: true do |t|
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["score"], name: "index_rates_on_score", unique: true

  create_table "ratings", force: true do |t|
    t.integer  "rate_id"
    t.integer  "rater_id"
    t.string   "rater_type"
    t.integer  "ratable_id"
    t.string   "ratable_type"    
    t.text     "review_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["ratable_id", "ratable_type"], name: "index_ratings_on_ratable_id_and_ratable_type"
  add_index "ratings", ["rate_id"], name: "index_ratings_on_rate_id"
  
  create_table "followees_followers", id: false, force: true do |t|
     t.integer "followee_id", null: false
     t.integer "follower_id", null: false
   end

  add_index "followees_followers", ["followee_id", "follower_id"], name: "index_followees_followers_on_followee_id_and_follower_id", unique: true
  

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "tag_id"], name: "index_taggings_on_taggable_id_and_taggable_type_and_tag_id", unique: true
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"

  create_table "tags", force: true do |t|
    t.string   "name",                           null: false
    t.text     "description"
    t.string   "group",       default: "global"
    t.datetime "created_at"
  end

  add_index "tags", ["name", "group"], name: "index_tags_on_name_and_group", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                 default: "",         null: false
    t.string   "password",              default: "",         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

  create_table "votes", force: true do |t|
    t.integer  "user_id",                  null: false
    t.integer  "votable_id",               null: false
    t.string   "votable_type",             null: false
    t.integer  "value",        default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id"], name: "index_votes_on_user_id"
  add_index "votes", ["votable_type", "votable_id", "user_id"], name: "index_votes_on_votable_type_and_votable_id_and_user_id", unique: true
  add_index "votes", ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"

end
