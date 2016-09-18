class UsersController < ApplicationController
  before_filter :authenticate_user!

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information update"
    else
      flash[:error] = "Incalid user information"
    end

    redirect_to edit_user_registration_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end