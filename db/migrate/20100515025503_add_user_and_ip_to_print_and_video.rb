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

class AddUserAndIpToPrintAndVideo < ActiveRecord::Migration
  def self.up
    add_column :prints, :user_id, :integer
    add_column :prints, :user_ip, :string
    add_column :videos, :user_id, :integer
    add_column :videos, :user_ip, :string

    add_index :prints, :user_id
    add_index :prints, :user_ip
    add_index :videos, :user_id
    add_index :videos, :user_ip
  end

  def self.down
    remove_index :prints, :user_id
    remove_index :prints, :user_ip
    remove_index :videos, :user_id
    remove_index :videos, :user_ip

    remove_column :prints, :user_id
    remove_column :prints, :user_ip
    remove_column :videos, :user_id
    remove_column :videos, :user_ip
  end
end
