class QuizzesController < ApplicationController
  before_action :set_quiz, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  load_and_authorize_resource param_method: :quiz_params, except: [ :restore, :submit_answer ]
  before_action :set_paper_trail_whodunnit

  def index
    @quizzes = Quiz.all
    @deleted_quizzes = Quiz.only_deleted
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def create
    @quiz = current_user.taught_quizzes.build(quiz_params)
    if @quiz.save
      redirect_to @quiz, notice: "สร้างแบบทดสอบเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update(quiz_params)
      redirect_to @quiz, notice: "อัปเดตแบบทดสอบเรียบร้อยแล้ว"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_path, notice: "ย้ายแบบทดสอบไปที่ถังขยะเรียบร้อยแล้ว"
  end

  def restore
    @quiz = Quiz.only_deleted.find(params[:id])
    authorize! :restore, @quiz
    @quiz.restore
    redirect_to quizzes_path, notice: "กู้คืนแบบทดสอบเรียบร้อยแล้ว"
  end

  def submit_answer
    @quiz = Quiz.find(params[:id])
    authorize! :read, @quiz

    @submission = current_user.quiz_submissions.find_or_initialize_by(quiz: @quiz)

    # Require params for quiz_submission and permit answer
    submission_params = params.require(:quiz_submission).permit(:answer)
    @submission.answer = submission_params[:answer]

    if @submission.save
      redirect_to @quiz, notice: "บันทึกคำตอบเรียบร้อยแล้ว", status: :see_other
    else
      redirect_to @quiz, alert: "เกิดข้อผิดพลาด ไม่สามารถบันทึกคำตอบได้", status: :see_other
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:question, :lesson_id)
  end
end
