class UserInfoPresentor
  def initialize(user, pair)
    @user = user
    @pair = pair
  end

  def info
    { me: { username: @user.username },
      pair: { username: @pair&.username, nickname: @pair&.nickname,
              pair_created_at: @user.pairs.active_created } }
  end
end
