require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:conor).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?

  end

  test "user should have a profile name without spaces" do
    user = User.new(first_name: 'conor', last_name: "O'Callaghan", email: 'conor2@mail.com')
    user.password = user.password_confirmation = 'asdfasdf'

    user.profile_name = "profile name with spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly")

  end

  test "user can have a correctly formatted profile name" do
    user = User.new(first_name: 'conor', last_name: "O'Callaghan", email: 'conor2@mail.com')
    user.password = user.password_confirmation = 'asdfasdf'

    user.profile_name = 'conoroc_2'

    assert user.valid?
  end
  test "no error when trying to access a friend list" do
    assert_nothing_raised do
      users(:conor).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:conor).friends << users(:mike)
    users(:conor).friends.reload
    assert users(:conor).friends.include?(users(:mike))
  end


end
