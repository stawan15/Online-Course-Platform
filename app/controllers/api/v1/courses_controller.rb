module Api
  module V1
    class CoursesController < BaseController
      # before_action :authenticate_user!
      before_action :set_course, only: [ :show, :update, :destroy, :log, :restore ]
      def index
        @courses = Course.all
        render json: @courses, status: :ok
      end

      def show
        render json: @course, status: :ok
      end

      def create
        @course = Course.new(course_params)
        if @course.save
          render json: @course,
          include: { lessons: { include: :quizzes } },
          status: :created
        else
          render json: { error: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @course.update(course_params)
          render json: { message: "Updated successfully" },
          status: :ok
        else
          render json: { error: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @course.destroy
          render json: { message: "Course deleted successfully" }, status: :ok
        else
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def log
        course_versions = {
          course: @course,
          "log": @course.versions }
        render json: course_versions, status: :ok
      end

      def deleted_courses
        @deleted_courses = Course.only_deleted
        render json: { deleted_courses: @deleted_courses }, status: :ok
      end

      def restore
        if @course.restore
          render json: { message: "Course restored successfully" }, status: :ok
        else
          render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_course
        @course = Course.with_deleted.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Course not found" }, status: :not_found
      end

      def course_params
        params.require(:course).permit(:title, :description, :user_id)
      end
    end
  end
end
