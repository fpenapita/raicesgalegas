# Copyright (C) 2010 Felipe Peña Pita
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License Version 3
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100515025503) do

  create_table "comments", :force => true do |t|
    t.string   "email",                          :null => false
    t.string   "name"
    t.text     "body",                           :null => false
    t.boolean  "private",     :default => false, :null => false
    t.integer  "emigrant_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["emigrant_id"], :name => "fk_comment_emigrant"

  create_table "emigrants", :force => true do |t|
    t.string   "name",                     :null => false
    t.string   "birth_place"
    t.integer  "birth_year"
    t.string   "destination_place"
    t.integer  "departure_year"
    t.text     "details"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "cached_tag_list"
    t.string   "cached_extended_tag_list"
    t.integer  "user_id",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emigrants", ["destination_place"], :name => "index_emigrants_on_destination_place"
  add_index "emigrants", ["name"], :name => "index_emigrants_on_name"
  add_index "emigrants", ["user_id"], :name => "fk_emigrant_user"

  create_table "prints", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "user_ip"
  end

  add_index "prints", ["user_id"], :name => "index_prints_on_user_id"
  add_index "prints", ["user_ip"], :name => "index_prints_on_user_ip"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.string   "email",                             :null => false
    t.string   "name",                              :null => false
    t.boolean  "accept_terms",                      :null => false
    t.string   "activation_code"
    t.datetime "activated_at"
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["activation_code"], :name => "index_users_on_activation_code"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "original_file_name"
    t.string   "original_file_size"
    t.string   "original_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "user_ip"
  end

  add_index "videos", ["user_id"], :name => "index_videos_on_user_id"
  add_index "videos", ["user_ip"], :name => "index_videos_on_user_ip"

  add_foreign_key "comments", "emigrants", :name => "fk_comment_emigrant"

  add_foreign_key "emigrants", "users", :name => "fk_emigrant_user"

end
