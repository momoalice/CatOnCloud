class UserAuthsController < ApplicationController
  def auth
    username = params["username"]
    password = params["password"]
    @user = UserAuth.where("name = \"#{username}\" and password = \"#{password}\"").take
    if @user
      render json: {status: 1, id: @user.user_id}
    else
      render json: {status: 0}
    end
  end
  

end
