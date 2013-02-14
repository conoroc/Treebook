require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
      end
    end

    context "when logged in" do
      setup do
        sign_in users(:conor)
      end

      should "get and return success" do
        get :new
        assert_response :success
      end

      should "get a flash message if the friend_id params is missing" do
        get :new, {}
        assert_equal "Friend Required", flash[:error]
      end

      should "display the friends name" do
        get :new, friend_id: users(:jim).id
        assert_match /#{users(:jim).full_name}/, response.body
      end

      should "assign a new user friendship" do
        get :new, friend_id: users(:jim).id
        assert assigns(:user_friendship)

      end

      should "assign a new user friendship to correct friend" do
        get :new, friend_id: users(:jim).id
        assert_equal users(:jim), assigns(:user_friendship).friend

      end
    end


  end

end
