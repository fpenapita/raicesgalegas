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

class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit]

  def index
    # This method avoids problems with the change of language when there are
    # problems with the new action (login)
    redirect_to :action => 'new'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save_without_session_maintenance
      flash[:notice] = t('user.create.succesful')
      redirect_back_or_default public_url
    else
      render :action => 'new'
    end
  end

  def activate
    if params[:activation_code]
      @user = User.find_by_activation_code(params[:activation_code])
      if @user && @user.activate

        # Authenticates automatically the user
        UserSession.create(@user)

        flash[:notice] = t('user.activation.succesful')
      else
        flash[:error] = t('user.activation.unable')
      end
    else
      flash.clear
    end

    redirect_to public_url
  end

  def edit
    @user = @current_user
  end
end
