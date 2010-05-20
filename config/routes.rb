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

ActionController::Routing::Routes.draw do |map|
  # Filter to add
  map.filter 'locale'

  # Sessions
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.resources :user_sessions

  # Users
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.activate_account 'activate_account/:activation_code', :controller => 'users', :action => 'activate'
  map.resources :users

  # Emigrants
  map.resources :emigrants
  map.family 'family', :controller => 'emigrants', :action => 'new'
  map.i_am_emigrant 'i_am_emigrant', :controller => 'emigrants', :action => 'new'
  map.add_comment 'add_comment', :controller => 'emigrants', :action => 'add_comment'
  map.find_tagged 'find_tagged', :controller => 'emigrants', :action => 'find_tagged'
  map.advanced_search 'advanced_search', :controller => 'emigrants', :action => 'advanced_search'
  map.atom_feed 'atom_feed', :controller => 'emigrants', :action => 'atom_feed', :format => 'atom'

  # Public pages
  map.connect '', :controller => 'public', :action => 'index'
  map.public '', :controller => 'public'
  map.general_error 'general_error', :controller => 'public', :action => 'general_error'
  map.terms_of_use 'terms_of_use', :controller => 'public', :action => 'terms_of_use'
  map.credits 'credits', :controller => 'public', :action => 'credits'

  # Attachments
  map.connect '/:controller/:id/:action/:style/:basename'
  map.prints '/prints/:id/:action/:style/:basename', :controller => 'attachments'

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
