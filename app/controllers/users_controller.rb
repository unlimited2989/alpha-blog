class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update]
    def new
        @user = User.new
    end

    def edit
        
    end

    def update


        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: "Your account was successfully updated" }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end


    end

    def create

        respond_to do |format|
            if @user.save
                session[:user_id] = @user.id
                format.html { redirect_to articles_path, notice: "Welcome to the Alpha Blog you have successfully sign up" }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
        @articles = @user.articles
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can only edit your own accounnt"
            redirect_to @user
        end
    end
end