class UserFriendshipDecorator < Draper::Decorator
  decorates :user_friendship
  delegate_all

  def friendship_state
    model.state.titleize
  end

  def sub_message
    case model.state
      when 'requested'
        "Are you sure you want to be friends with #{model.friend.first_name}?"
      when 'pending'
        "Friend request is pending"
      when 'accepted'
        "You are friends with #{model.friend.first_name}."
    end
  end

end
