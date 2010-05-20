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

class UserMailer < ActionMailer::Base

  def signup(user)
    setup_user_mail(user)
    subject    I18n.t 'user.mail.created.subject'
  end

  def activation(user)
    setup_user_mail(user)
    subject    I18n.t 'user.mail.activated.subject'
  end

  protected

  def setup_user_mail(user)
    recipients  user.email
    from        DEFAULT_FROM_MAIL
    sent_on     = Time.now
    body        :user => user
  end
end
