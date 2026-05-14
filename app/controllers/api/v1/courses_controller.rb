module Api
  module V1
    class CoursesController < BaseController
      before_action :set_course, only: [ :show, :update, :destroy, :restore, :log_history ]

      def index
        @courses = Course.all
        render json: @courses
      end

      def show
        render json: @course
      end

      def create
        @course = Course.new(course_params)
        if @course.save
          render json: @course, status: :created
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def update
        if @course.update(course_params)
          render json: @course
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @course.destroy
        render json: { message: "Course deleted" }
      end

      def log_history
        @course.versions
        render json: @course.versions
      end


      def restore
        @course.restore!
        render json: { message: "Course restored" }
      end

      private

      def set_course
        @course = Course.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Course not found" }, status: :not_found
      end

      def course_params
        params.require(:course).permit(:title, :description)
      end
    end
  end
end
