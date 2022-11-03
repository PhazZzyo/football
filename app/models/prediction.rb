class Prediction < ApplicationRecord    
    belongs_to :user
    belongs_to :match
    
    after_create :calculate
    
    def calculate        
        result = 0
        
        if (self.match.home_team_score == home_team_score && self.match.visitor_team_score == visitor_team_score)
            result = 3
        elsif (self.match.home_team_score > match.visitor_team_score && home_team_score > visitor_team_score)
            result = 1
        elsif (self.match.visitor_team_score > self.match.home_team_score && visitor_team_score > home_team_score)
            result = 1  
        else
            result = 0
        end
        
        user.points = user.points + result
        user.save        
    end
end
