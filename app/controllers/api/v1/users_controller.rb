# api for user
module Api
  module V1
    class UsersController < BaseController
      # before_action :authenticate_user!
      before_action :set_user, only: [ :show, :update, :destroy, :log, :restore ]
      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def show
        render json: @user, status: :ok
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user,
          status: :created
        else
          render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: { message: "Updated successfully" },
          status: :ok
        else
          render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy
          render json: { message: "User deleted successfully" }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def log
        user_versions = {
          user: @user,
          "log": @user.versions }
        render json: user_versions, status: :ok
      end

      def deleted_users
        @deleted_users = User.only_deleted
        render json: { deleted_users: @deleted_users }, status: :ok
      end

      def restore
        if @user.restore
          render json: { message: "User restored successfully" }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.with_deleted.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
