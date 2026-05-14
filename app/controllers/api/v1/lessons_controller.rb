module Api
  module V1
    class LessonsController < BaseController
      # before_action :authenticate_user!
      before_action :set_lesson, only: [ :show, :update, :destroy, :log, :restore ]
      def index
        @lessons = Lesson.all
        render json: @lessons, status: :ok
      end

      def show
        render json: @lesson, status: :ok
      end

      def create
        @lesson = Lesson.new(lesson_params)
        if @lesson.save
          render json: @lesson,
          include: { quizzes: { include: :quiz_submissions } },
          status: :created
        else
          render json: { error: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @lesson.update(lesson_params)
          render json: { message: "Updated successfully" },
          status: :ok
        else
          render json: { error: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @lesson.destroy
          render json: { message: "Lesson deleted successfully" }, status: :ok
        else
          render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def log
        lesson_versions = {
          lesson: @lesson,
          "log": @lesson.versions }
        render json: lesson_versions, status: :ok
      end

      def deleted_lessons
        @deleted_lessons = Lesson.only_deleted
        render json: { deleted_lessons: @deleted_lessons }, status: :ok
      end

      def restore
        if @lesson.restore
          render json: { message: "Lesson restored successfully" }, status: :ok
        else
          render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_lesson
        @lesson = Lesson.with_deleted.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Lesson not found" }, status: :not_found
      end

      def lesson_params
        params.require(:lesson).permit(:title, :description, :course_id)
      end
    end
  end
end
