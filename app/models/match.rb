class Match < ApplicationRecord
    enum status: {
    planned: :planned,
    live: :live,
    ended: :ended,
    canceled: :canceled,
    }
    has_many :predictions
    belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
    belongs_to :visitor_team, class_name: "Team", foreign_key: "visitor_team_id"
end
