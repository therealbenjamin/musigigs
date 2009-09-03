require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  def setup
    @controller = SiteController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_index
    get :index
    title = assigns(:title)
    assert_equal "Welcome to Musigigs!", title
    assert_response :success
    assert_template "index"
  end
  
  def test_about
    get :about
    title = assigns(:title)
    assert_equal "About Musigigs", title
    assert_response :success
    assert_template "about"
  end
  
  def test_help
    get :help
    title = assigns(:title)
    assert_equal "Musigigs Help", title
    assert_response :success
    assert_template "help"
  end
  
  # Test the navigation menu before login.
  def test_navigation_not_logged_in
    get :index
    assert_tag "a", :content => /Register/,
                    :attributes => { :href => "/user/register" }
    assert_tag "a", :content => /Login/,
                    :attributes => { :href => "/user/login" }
    # Test link_to_unless_current.
    assert_no_tag "a", :content => /Home/
  end                                                       


end
