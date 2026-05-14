module Api
  module V1
    class ProfilesController < BaseController
      # before_action :authenticate_user!
      before_action :set_profile, only: [ :show, :update, :destroy, :log, :restore ]
      def index
        @profiles = Profile.all
        render json: @profiles, status: :ok
      end

      def show
        render json: @profile, status: :ok
      end

      def create
        @profile = Profile.new(profile_params)
        if @profile.save
          render json: @profile,
          status: :created
        else
          render json: { error: @profile.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @profile.update(profile_params)
          render json: { message: "Updated successfully" },
          status: :ok
        else
          render json: { error: @profile.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @profile.destroy
          render json: { message: "Profile deleted successfully" }, status: :ok
        else
          render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def log
        profile_versions = {
          profile: @profile,
          "log": @profile.versions }
        render json: profile_versions, status: :ok
      end

      def deleted_profiles
        @deleted_profiles = Profile.only_deleted
        render json: { deleted_profiles: @deleted_profiles }, status: :ok
      end

      def restore
        if @profile.restore
          render json: { message: "Profile restored successfully" }, status: :ok
        else
          render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_profile
        @profile = Profile.with_deleted.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Profile not found" }, status: :not_found
      end

      def profile_params
        params.require(:profile).permit(:name, :bio, :user_id)
      end
    end
  end
end
