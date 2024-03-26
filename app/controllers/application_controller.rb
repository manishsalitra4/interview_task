
class ApplicationController < ActionController::API
	before_action :authorized, except: [ :login] 
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def encode_token(payload)
        JWT.encode(payload, 'hellomars1211') 
    end

    def decoded_token
        token = request.headers['token']
        if token
            begin

                JWT.decode(token, 'hellomars1211', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user 

        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end



    def authorized
        unless !!current_user
        render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end

end