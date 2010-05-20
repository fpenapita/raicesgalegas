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

class UserMailerTest < ActionMailer::TestCase
  test "signup" do
    @expected.subject = 'UserMailer#signup'
    @expected.body    = read_fixture('signup')
    @expected.date    = Time.now

    assert_equal @expected.encoded, UserMailer.create_signup(@expected.date).encoded
  end

  test "activation" do
    @expected.subject = 'UserMailer#activation'
    @expected.body    = read_fixture('activation')
    @expected.date    = Time.now

    assert_equal @expected.encoded, UserMailer.create_activation(@expected.date).encoded
  end

end
