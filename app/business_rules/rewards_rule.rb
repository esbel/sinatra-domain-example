class RewardsRule
  MAPPING = {
    "KIDS"   => nil,
    "MUSIC"  => "KARAOKE_PRO_MICROPHONE",
    "MOVIES" => "PIRATES_OF_THE_CARIBBEAN_COLLECTION",
    "NEWS"   => nil,
    "SPORTS" => "CHAMPIONS_LEAGUE_FINAL_TICKET"
  }

  def call(channels)
    rewards = channels.map do |channel|
      reward_name = MAPPING[channel.name]

      Reward.new(reward_name) unless reward_name.nil?
    end

    rewards.compact
  end
end
