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

class CommentMailer < ActionMailer::Base

  def comment(comment, sent_at = Time.now)
    subject         I18n.t('comment.mail.subject')
    recipients      comment.emigrant.user.email
    from            DEFAULT_FROM_MAIL
    body            :comment => comment
    sent_on         sent_at
  end

end
