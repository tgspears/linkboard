class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        info = user_params
        user = User.find_by_email(info[:email])

        if user
            flash[:danger] = "This email is already registered"
            redirect_to new_user_path
        else
            User.create(email: info[:email]) do |u|
                u.password = info[:password]
            end
            flash[:success] = "User succesfully signed up, please login."
            redirect_to login_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:email,:password)
    end

end