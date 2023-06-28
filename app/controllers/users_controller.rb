class UsersController < ApplicationController
    def create
        user = User.new(user_params)
    
        if user.save
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      private
    
      
      
      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :image_url, :bio)
      end
      
    end


  def show
    if logged_in?
      user = User.find(session[:user_id])
      render json: user, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
