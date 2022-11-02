class CreateTeams < ActiveRecord::Migration[7.0]
    def change
        create_table :teams do |t|
            t.string :name
            t.integer :matches_won
            
            t.timestamps
        end
    end
end
