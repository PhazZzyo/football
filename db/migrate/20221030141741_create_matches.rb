class CreateMatches < ActiveRecord::Migration[7.0]
    def change
        create_table :matches do |t|
            t.datetime :date
            t.integer :status, default: 2
            t.bigint :home_team_id
            t.integer :home_team_score, default: 0
            t.bigint :visitor_team_id
            t.integer :visitor_team_score, default: 0
            
            t.timestamps
        end
        
        add_foreign_key :matches, :teams, column: :home_team_id
        add_foreign_key :matches, :teams, column: :visitor_team_id    
    end
end
