class LikesController < ApplicationController
    before_action :require_login, only: [:create, :destroy]

    def create
        secret = Secret.find(params["secret_id"])
        Like.create(user: current_user, secret: secret)
        redirect_to :back
    end
    
    def destroy
        Like.find(params[:id]).destroy
        redirect_to :back
    end
end
