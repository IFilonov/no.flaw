class PairInfoPresentor
  def initialize(user, pair)
    @user = user
    @pair = pair
  end

  def info
    { me: @user.as_json(only: %i[id username]),
      pair: { username: @pair&.username, nickname: @pair&.nickname,
              pair_created_at: @pair&.created_at,
              id: @pair&.id } }
  end
end
