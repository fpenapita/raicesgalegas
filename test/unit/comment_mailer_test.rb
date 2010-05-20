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

require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  test "comment" do
    @expected.subject = 'CommentMailer#comment'
    @expected.body    = read_fixture('comment')
    @expected.date    = Time.now

    assert_equal @expected.encoded, CommentMailer.create_comment(@expected.date).encoded
  end

end
