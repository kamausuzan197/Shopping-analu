class UsersController < ApplicationController
    # handles create and autologin
    skip_before_action :authorize, only: :create


    def index
      users=User.all
      render json:users
    end

    def show
      user = User.find_by(id: session[:user_id])
      if user
      render json: user
      else
          render json: { error: "Not authorized" }, status: :unauthorized
      end
  end


 
    def create
      user = User.create!(user_params)
      session[:user_id] = user.id
      render json: user, status: :created
    end
 
    def show
      render json: @current_user
    end
 
    private
 
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
 end