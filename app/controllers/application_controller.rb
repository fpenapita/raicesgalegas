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

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation

  before_filter :set_locale
  before_filter :get_highlighted_emigrants

  helper_method :current_user

  alias_method :rescue_action_locally, :rescue_action_in_public if RAILS_ENV == 'development'

  def render_optional_error_file(status_code)
    status = interpret_status(status_code)
    message = t("general_errors.html_code.error_#{status[0,3]}")

    if (message.blank?)
      super
    else
      flash[:error] = message
      redirect_to general_error_url
    end
  end

  protected

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = (AVAILABLE_LOCALES.keys.include? params[:locale]) ? params[:locale] : nil
    @available_locales = AVAILABLE_LOCALES
  end

  def default_url_options(options={})
    # logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)

    # We could cache the user of the current session to avoid too many queries
    # to ddbb to recover the user in each request. If we use this, we also need to
    # uncomment in user_sessions_controler the line cache_store.delete(session["user_credentials"])
    # in the destroy method to delete the user of cache when he logouts.
    #
    # Finally, we dont use it for security reasons, because a error in the use
    # of the cache could give admin access to some other users
    # @current_user = cache(session["user_credentials"]) {current_user_session && current_user_session.record}

    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = t('login.must_be_logged_in')
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = t('login.must_be_logged_out')
      redirect_to public_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def get_highlighted_emigrants
    @highlighted_emigrants = Emigrant.find_highlighted_emigrants
  end
end
