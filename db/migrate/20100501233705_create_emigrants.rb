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

class CreateEmigrants < ActiveRecord::Migration
  def self.up
    create_table :emigrants do |t|
      t.string :name,                 :null => false
      t.string :birth_place
      t.integer :birth_year
      t.string :destination_place
      t.integer :departure_year
      t.text :details
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.string :cached_tag_list
      t.string :cached_extended_tag_list
      t.integer :user_id,             :null => false
      
      t.timestamps
    end

    add_index :emigrants, :name
    add_index :emigrants, :destination_place

    add_foreign_key(:emigrants, :users, :name => 'fk_emigrant_user')
  end

  def self.down
    remove_foreign_key(:emigrants, :name => 'fk_emigrant_user')

    remove_index :emigrants, :destination_place
    remove_index :emigrants, :name

    drop_table :emigrants
  end
end
