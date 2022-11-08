class Match < ApplicationRecord
    validates :date, presence: true    
    enum status: %i[planned live ended canceled], _default: "ended"
    has_many :predictions
    belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
    belongs_to :visitor_team, class_name: "Team", foreign_key: "visitor_team_id"
end
