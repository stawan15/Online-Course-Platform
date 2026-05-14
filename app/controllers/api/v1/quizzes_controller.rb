module Api
  module V1
    class QuizzesController < BaseController
      # before_action :authenticate_user!
      before_action :set_quiz, only: [ :show, :update, :destroy, :log, :restore ]
      def index
        @quizzes = Quiz.all
        render json: @quizzes, status: :ok
      end

      def show
        render json: @quiz, status: :ok
      end

      def create
        @quiz = Quiz.new(quiz_params)
        if @quiz.save
          render json: @quiz,
          status: :created
        else
          render json: { error: @quiz.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @quiz.update(quiz_params)
          render json: { message: "Updated successfully" },
          status: :ok
        else
          render json: { error: @quiz.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @quiz.destroy
          render json: { message: "Quiz deleted successfully" }, status: :ok
        else
          render json: { errors: @quiz.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def log
        quiz_versions = {
          quiz: @quiz,
          "log": @quiz.versions }
        render json: quiz_versions, status: :ok
      end

      def deleted_quizzes
        @deleted_quizzes = Quiz.only_deleted
        render json: { deleted_quizzes: @deleted_quizzes }, status: :ok
      end

      def restore
        if @quiz.restore
          render json: { message: "Quiz restored successfully" }, status: :ok
        else
          render json: { errors: @quiz.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_quiz
        @quiz = Quiz.with_deleted.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Quiz not found" }, status: :not_found
      end

      def quiz_params
        params.require(:quiz).permit(:title, :description, :lesson_id)
      end
    end
  end
end
