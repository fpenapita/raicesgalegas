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

class Emigrant < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :extended_tags

  belongs_to :user
  has_many :comments

  has_attached_file :photo,
    :styles => { :medium => "400x400#", :thumb => "100x100#" },
    :default_url => "/images/default_:style_avatar.jpg",
    :path => ATTACHMENTS_PATH, :url => ATTACHMENTS_URL

  validates_presence_of :name, :user_id
  validates_numericality_of :birth_year, :departure_year, :only_integer => true, :allow_nil => true, :allow_blank => true

  validates_attachment_size :photo, :less_than => ATTACHMENTS_MAX_FILE_SIZE,
    :message => I18n.t('paperclip.validate_attachment_size_error')

  validates_attachment_content_type :photo,
    :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png'],
    :message => I18n.t('paperclip.validate_attachment_content_type_error')

  def self.find_last_emigrants
    find(:all, :limit => EMIGRANTS_TO_HIGHLIGHT, :order => "created_at desc")
  end

  def self.find_highlighted_emigrants
    find(:all, :limit => EMIGRANTS_TO_HIGHLIGHT, :order => "rand()")
  end

  def self.find_tagged(tag, page)
    emigrants_aux = self.tagged_with(tag, :on => :extended_tags)

    num_page = page.blank? ? 1 : page.to_i

    @emigrants = WillPaginate::Collection.create(num_page, RESULTS_PER_PAGE, emigrants_aux.size()) do |pager|
      start = (num_page - 1) * RESULTS_PER_PAGE # assuming current_page is 1 based.
      pager.replace(emigrants_aux[start, RESULTS_PER_PAGE])
    end
  end

  def self.advanced_search(search, page)
    condition = ''
    is_first = true
    search_options = {}

    if search
      search.each_pair do |k,v|
        unless v.blank?
          if !is_first
            condition += ' and '
          end

          if ADVANCED_SEARCH_FIELDS.include?(k)
            if TEXT_ADVANCED_SEARCH_FIELDS.include?(k)
              condition += k.to_s + ' like :' + k
              search_options[k.to_sym] = ('%' + v + '%')
            else
              condition += k.to_s + ' = :' + k
              search_options[k.to_sym] = v
            end
          end

          is_first = false
        end
      end
    end

    paginate :page => (page.blank? ? 1 : page.to_i), :per_page => RESULTS_PER_PAGE,
        :conditions => [condition, search_options], :order => 'created_at desc'
  end

  protected

  def after_validation
    extended_tag_list_aux = tag_list.split(/[ ,]/)
    extended_tag_list_aux << name.split(' ')
    extended_tag_list_aux << birth_place unless birth_place.blank?
    extended_tag_list_aux << birth_year unless birth_year.blank?
    extended_tag_list_aux << destination_place unless destination_place.blank?
    extended_tag_list_aux << departure_year unless departure_year.blank?

    self.extended_tag_list = extended_tag_list_aux.join(',')
  end
end
