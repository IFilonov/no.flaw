class PairInfoPresentor
  def initialize(user, pair)
    @user = user
    @pair = pair
  end

  def info
    pair = @user.pairs.active
    { me: { username: @user.username },
      pair: { username: @pair&.username, nickname: @pair&.nickname,
              pair_created_at: pair&.created_at,
              id: pair&.id } }
  end
end
