class UsersController < ApplicationController

    def index 
        render json: User.all.to_json(user_serializer_options)
    end 

    def show 
        user = User.find(params[:id])
        render json: user.to_json(user_serializer_options)
    end

    def create 
        user = User.find_or_create_by(user_params)
        render json: user.to_json(user_serializer_options)
    end

    private 

    def user_params
        params.require(:user).permit(:name, :image)
    end

    def user_serializer_options()
        {   :include => { 
            :user_moods => { 
                :except => [:created_at, :updated_at], 
                :include => {
                    :mood => {
                        :except => [:created_at, :updated_at]
                        }
                    }
                },
                :activities => {
                    :only => :name,
                    :except => [:created_at, :updated_at]
                }
        },
            :except => [:created_at, :updated_at]
        }
    end
end