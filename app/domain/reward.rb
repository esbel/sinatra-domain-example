class Reward
  attr :name

  def initialize(name)
    @name = name
  end

  def ==(other_reward)
    name == other_reward.name
  end
end
