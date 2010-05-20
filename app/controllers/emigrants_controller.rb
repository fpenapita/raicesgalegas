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

class EmigrantsController < ApplicationController
  before_filter :require_user, :only => [:new, :edit, :create, :update]
  before_filter :belongs_to_current_user, :only => [:edit, :update, :destroy]

  uses_tiny_mce :options => AppConfig.custom_mce_options, :only => [:new, :create, :show, :edit, :update]

  def index
    @emigrants = Emigrant.paginate :page => params[:page] || 1,
      :per_page => RESULTS_PER_PAGE,
      :order => 'created_at desc'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @emigrants }
    end
  end

  def atom_feed
    @emigrants = Emigrant.all(:order => 'created_at desc')

    respond_to do |format|
      format.atom
    end
  end

  def find_tagged
    tag = params[:tag]||params[:search][:tag]
    @params_pagination = {:tag => tag}
    @emigrants = Emigrant.find_tagged(tag, params[:page])

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @emigrants }
    end
  end

  def advanced_search
    @params_pagination = {:search => params[:search]}
    @emigrants = Emigrant.advanced_search(params[:search], params[:page])

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @emigrants }
    end
  end

  def show
    @emigrant = Emigrant.find(params[:id])
    @private_comments = @emigrant.comments.count(:all, :conditions => ['private = 1'])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @emigrant }
    end
  end

  def new
    @emigrant = Emigrant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @emigrant }
    end
  end

  def edit
    @emigrant = Emigrant.find(params[:id])
  end

  def create
    @emigrant = Emigrant.new(params[:emigrant])
    @emigrant.user = @current_user

    respond_to do |format|
      if @emigrant.save
        flash[:notice] = t('emigrant.created_successfully')
        format.html { redirect_to(@emigrant) }
        format.xml  { render :xml => @emigrant, :status => :created, :location => @emigrant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @emigrant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @emigrant = Emigrant.find(params[:id])
    @emigrant.user = @current_user

    respond_to do |format|
      if @emigrant.update_attributes(params[:emigrant])
        flash[:notice] = t('emigrant.updated_successfully')
        format.html { redirect_to(@emigrant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @emigrant.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_comment
    @emigrant = Emigrant.find(params[:emigrant_id])
    @comment = Comment.new(params[:comment])
    @comment.emigrant = @emigrant
    @comment.save!
    @private_comments = @emigrant.comments.count(:all, :conditions => ['private = 1'])
    respond_to do |format|
      format.html { redirect_to @emigrant }
      format.js
    end
  rescue
    respond_to do |format|
      format.html {
        @private_comments = @emigrant.comments.count(:all, :conditions => ['private = 1'])
        render :action => 'show'
      }
      format.js {
        render :update do |page|
          page.replace_html :comment_errors, error_messages_for(:comment)
          page.visual_effect :highlight, :errors, :duration => 2
        end
      }
    end
  end

  def destroy
    @emigrant = Emigrant.find(params[:id])
    @emigrant.destroy

    respond_to do |format|
      format.html { redirect_to(emigrants_url) }
      format.xml  { head :ok }
    end
  end

  def photos
    # FIXME Avoid go to ddbb
    @emigrant = Emigrant.find(params[:id])
    if (@emigrant.photo.file? &&
        @emigrant.photo.original_filename.parameterize == params[:basename])
      send_file @emigrant.photo.path(params[:style]), :type => @emigrant.photo_content_type
    end
  end

  protected

  def belongs_to_current_user
    @emigrant = Emigrant.find(params[:id])

    unless current_user == @emigrant.user
      flash[:error] = t('emigrant.dont_allow')
      redirect_to general_error_url
      return false
    end
  end
end
