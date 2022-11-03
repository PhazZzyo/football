require 'faker'

# Match.destroy_all
# Prediction.destroy_all
# Team.destroy_all
# User.destroy_all

random = Random.new

11.times do |index| 
    team = Team.create(id: Faker::Number.unique.within(range: 1..11), name: Faker::Sports::Football.unique.team)
end

11.times do |index|
    match = Match.create(id: Faker::Number.unique.within(range: 24..35), date: rand(DateTime.now..30.days.from_now.to_datetime), status: 'ended', home_team_id: random.rand(1..11), home_team_score: random.rand(0..5), visitor_team_id: random.rand(1..11), visitor_team_score: random.rand(0..5))
end

11.times do |index| 
    user = User.create(id: Faker::Number.unique.within(range: 12..23), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
end