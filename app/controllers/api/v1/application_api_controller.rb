class Api::V1::ApplicationApiController < ActionController::API
    require 'jwt'
    include ActionController::MimeResponds
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authorization 
    skip_before_action :authorization, only: [:get_token]
    
    def get_token
        current_user = User.find_by(email: login_params[:email] )
        payload = {}
        hmac_secret = Rails.application.credentials.SECRET
        iat = Time.now.to_i
        exp = Time.now.to_i + 3600
        payload[:iat] = iat
        payload[:exp] = exp
        payload[:email] = current_user.email
        payload[:user_id] = current_user.id
        token = JWT.encode payload, hmac_secret, 'HS256'
        respond_to do |format|
            format.xml {render xml: token, status: 404}
            format.json {render json: {message: 'Token generated', token: token}, status: 404}  
        end
    end
    
    def not_found
        render json: {error: "not_found"}
    end
    
    def authorization
        hmac_secret = Rails.application.credentials.SECRET
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            decoded_token = JWT.decode header, hmac_secret, 'HS256'    
            user_id = decoded_token[0]["user_id"] unless !decoded_token
            user = User.find(user_id)
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::ExpiredSignature => e
            render json: { errors: e.message }, status: :unauthorized  
        end
    end
    
    private
    def login_params
        params.fetch(:user, {})
    end
end