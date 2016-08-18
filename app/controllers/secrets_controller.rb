class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]

    def index
        @secrets = Secret.all
    end

    def create
        @secret = Secret.new(content: params[:new_secret], user: current_user)
        if @secret.save
          redirect_to current_user
        else

          flash[:errors] = @secret.errors.full_messages
          redirect_to :back
        end
    end

    def destroy
        secret = Secret.find(params[:id])
        secret.destroy if secret.user == current_user
        redirect_to "/users/#{current_user.id}"
    end
    
end
