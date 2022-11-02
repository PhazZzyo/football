namespace :prediction do
    desc "Prediction create"
    task :create => :environment do    
        prediction = Prediction.create(home_team_score: 4, visitor_team_score: 5, match_id: 33, user_id: 23)
        prediction = Prediction.create(home_team_score: 2, visitor_team_score: 2, match_id: 32, user_id: 21)
        prediction = Prediction.create(home_team_score: 2, visitor_team_score: 3, match_id: 33, user_id: 14)
        prediction = Prediction.create(home_team_score: 2, visitor_team_score: 3, match_id: 33, user_id: 21)
        prediction = Prediction.create(home_team_score: 4, visitor_team_score: 1, match_id: 32, user_id: 23)
    end
    
    desc "Prediction winner"
    task :winner => :environment do
        wins = User.where(points: User.maximum("points")).pluck(:first_name, :last_name).join(' ')
        puts "Winner is: " + wins
    end
end