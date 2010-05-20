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

class Print < ActiveRecord::Base

  belongs_to :user

  has_attached_file :image,
    :convert_options => { :quality =>  4 },
    :styles => {
          :small_thumb => [ "50x50", :jpg ],
	        :medium_thumb => [ "100x100", :jpg ],
          :large_thumb => [ "370x370", :jpg ],
	        :detail_preview => [ "450x338", :jpg ]
	  },
    #:path => "/prints/:id/:style.:extension",
    :default_url => "/images/missing/prints/:style.png",
    :url => MAILER_AND_TINY_MCE_ATTACHMENTS_URL,
    :path => MAILER_AND_TINY_MCE_ATTACHMENTS_PATH

    validates_attachment_content_type :image,
      :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png'],
      :message => I18n.t('paperclip.validate_attachment_content_type_error')
end
