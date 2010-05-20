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

class EmigrantsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emigrants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emigrant" do
    assert_difference('Emigrant.count') do
      post :create, :emigrant => { }
    end

    assert_redirected_to emigrant_path(assigns(:emigrant))
  end

  test "should show emigrant" do
    get :show, :id => emigrants(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => emigrants(:one).to_param
    assert_response :success
  end

  test "should update emigrant" do
    put :update, :id => emigrants(:one).to_param, :emigrant => { }
    assert_redirected_to emigrant_path(assigns(:emigrant))
  end

  test "should destroy emigrant" do
    assert_difference('Emigrant.count', -1) do
      delete :destroy, :id => emigrants(:one).to_param
    end

    assert_redirected_to emigrants_path
  end
end
