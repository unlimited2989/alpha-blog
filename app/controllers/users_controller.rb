class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

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
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                flash[:notice] = "Welcome to the Alpha Blog you have successfully sign up"
                redirect_to articles_path
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def show
        @user = User.find(params[:id])
        @articles = @user.articles
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end