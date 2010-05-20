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

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login,              :null => false
      t.string :crypted_password,   :null => false
      t.string :password_salt,      :null => false
      t.string :persistence_token,  :null => false

      t.string :email,              :null => false
      t.string :name,               :null => false
      t.boolean :accept_terms,      :null => false
      t.string :activation_code
      t.datetime :activated_at

      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip

      t.timestamps
    end

    add_index :users, :login, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :activation_code
  end

  def self.down
    remove_index :users, :activation_code
    remove_index :users, :email
    remove_index :users, :login

    drop_table :users
  end
end
