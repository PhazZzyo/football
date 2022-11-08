require_relative "./application_api_controller"
include ActionController::MimeResponds


class Api::V1::MatchesController < ApplicationApiController
    # GET /matches or /matches.json (or xml)
    def index
        @matches = Match.all    
        @matches_teams = @matches.collect {|match| [ "#{match.home_team.name} vs #{match.visitor_team.name}", match.id ] }
        respond_to do |format|
            format.json { render json: @matches, status: 200 }
            format.xml { render xml: @matches, status: 200 }
        end
    end
    
    # GET /matches/:id or /matches/:id.json (or xml)
    def show
        @match = Match.find(params[:id])
        respond_to do |format|
            format.json { render json: @match, status: 200}
            format.xml { render xml: @match, status: 200 }
        end 
    end
    
    # POST /matches or /matches.json (or xml)
    def create
        @match = Match.new(match_params)
        
        if(@match.home_team_id == @match.visitor_team_id)
            render error: { error: "Chose another team please"}, status: 400 
            return
        end 
        
        respond_to do |format|
            if @match.save
                format.json  { render json: @match }
                format.xml  { render xml: @match }
            else
                render error: { error: "Unable to create Match"}, status: 400
            end
        end
    end
    
    # PATCH/PUT /matches/:id or /matches/:id.json (or xml)
    def update
        @match = Match.find(params[:id])    
        
        respond_to do |format|
            if @match
                @match.update(match_params)
                format.json { render json: { message: "Match successfully updated!" }, status: 200 }
                format.xml { render xml: { message: "Match successfully updated!" }, status: 200 }
            else
                format.json { render json: { error: "Unable to update Match" }, status: 400 }
                format.xml { render xml: { error: "Unable to update Match" }, status: 400 }
            end
        end
        if(match_params[:stage] == "finished")
            CalculatePointsJob.perform_later()
        end
    end
    
    # DELETE /matches/:id or /matches/:id.json (or xml)
    def destroy
        @match = Match.find(params[:id])
        respond_to do |format|
            if @match
                @match.destroy
                format.json { render json: { message: "Match succesfuly deleted" }, status: 200 }
                format.xml { render xml: { message: "Match succesfuly deleted" }, status: 200 }
            else
                format.json { render json: { error: "Unable to delete Match" }, status: 400 }
                format.xml { render xml: { error: "Unable to delete Match" }, status: 400 }
            end
        end
    end
    
    private
    def match_params
        params.fetch(:match, {}).permit(:date, :stage, :home_team_id, :visitor_team_id, :home_team_score, :visitor_team_score)
    end
end