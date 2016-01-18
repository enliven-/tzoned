FactoryGirl.define do
  factory :timezone do
    name            ['IST', 'GMT', 'PT', 'PST'].sample
    city_id         (1..5).to_a.sample
    gmt_difference  (0..3).step(0.5).to_a.sample * 60 * 60
    user_id         (1..3).to_a.sample
  end

end
