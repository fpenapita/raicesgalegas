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

class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def index
    # This method avoids problems with the change of language when there are
    # problems with the new action (login)
    redirect_to :action => 'new'
  end

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t('login.successful.login')
      redirect_back_or_default public_url
    else
      render :action => 'new'
    end
  end

  def destroy
    # See AplicationController.current_user to understand the comment line
    # cache_store.delete(session["user_credentials"])

    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = t('login.successful.logout')
    redirect_back_or_default public_url
  end
end
