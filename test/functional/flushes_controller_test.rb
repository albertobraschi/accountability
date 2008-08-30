require File.dirname(__FILE__) + '/../test_helper'
require 'flushes_controller'

# Re-raise errors caught by the controller.
class FlushesController; def rescue_action(e) raise e end; end

class FlushesControllerTest < Test::Unit::TestCase
  fixtures :flushes

  def setup
    @controller = FlushesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:flushes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_flush
    old_count = Flush.count
    post :create, :flush => { }
    assert_equal old_count + 1, Flush.count

    assert_redirected_to flush_path(assigns(:flush))
  end

  def test_should_show_flush
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_flush
    put :update, :id => 1, :flush => { }
    assert_redirected_to flush_path(assigns(:flush))
  end

  def test_should_destroy_flush
    old_count = Flush.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Flush.count

    assert_redirected_to flushes_path
  end
end
