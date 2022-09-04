class SessionsController < ApplicationController
    def new

    end

    def create
       
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] =  "Logged in successfully" 
            redirect_to user
        else 
            redirect_to login_path
            flash[:alert] = "There was something worng with your login detail"
            
        end
    
        
    end

    def destroy
        session[:user_id] = nil 
        flash[:notice] = "Logged out"
        redirect_to login_path
    end
end
