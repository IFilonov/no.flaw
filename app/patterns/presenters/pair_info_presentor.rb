class PairInfoPresentor
  def initialize(user, pair)
    @user = user
    @pair = pair
  end

  def info
    { me: @user.as_json(only: %i[id username nickname]),
      pair: { username: @pair&.username, nickname: @pair&.nickname,
              pair_created_at: @pair&.created_at,
              id: @pair&.id } }.with_indifferent_access
  end
end
