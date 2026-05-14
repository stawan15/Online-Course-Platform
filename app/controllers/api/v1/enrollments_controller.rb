module Api
  module V1
    class EnrollmentsController < BaseController
      # before_action :authenticate_user!
      before_action :set_enrollment, only: [ :show, :update, :destroy, :log, :restore ]
      def index
        @enrollments = Enrollment.all
        render json: @enrollments, status: :ok
      end

      def show
        render json: @enrollment, status: :ok
      end

      def create
        @enrollment = Enrollment.new(enrollment_params)
        if @enrollment.save
          render json: @enrollment,
          status: :created
        else
          render json: { error: @enrollment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @enrollment.update(enrollment_params)
          render json: { message: "Updated successfully" },
          status: :ok
        else
          render json: { error: @enrollment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @enrollment.destroy
          render json: { message: "Enrollment deleted successfully" }, status: :ok
        else
          render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def log
        enrollment_versions = {
          enrollment: @enrollment,
          "log": @enrollment.versions }
        render json: enrollment_versions, status: :ok
      end

      def deleted_enrollments
        @deleted_enrollments = Enrollment.only_deleted
        render json: { deleted_enrollments: @deleted_enrollments }, status: :ok
      end

      def restore
        if @enrollment.restore
          render json: { message: "Enrollment restored successfully" }, status: :ok
        else
          render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_enrollment
        @enrollment = Enrollment.with_deleted.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Enrollment not found" }, status: :not_found
      end

      def enrollment_params
        params.require(:enrollment).permit(:user_id, :course_id)
      end
    end
  end
end
