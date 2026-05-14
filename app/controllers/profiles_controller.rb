class ProfilesController < ApplicationController
  before_action :set_profile, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :show ]
  load_and_authorize_resource param_method: :profile_params, except: [ :restore ]
  before_action :set_paper_trail_whodunnit

  def show
  end

  def new
    @profile = current_user.build_profile
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile, notice: "สร้างโปรไฟล์เรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "อัปเดตโปรไฟล์เรียบร้อยแล้ว"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    redirect_to root_path, notice: "ย้ายโปรไฟล์ไปที่ถังขยะเรียบร้อยแล้ว"
  end

  def restore
    @profile = Profile.only_deleted.find_by(user_id: current_user.id)
    authorize! :restore, @profile
    @profile.restore
    redirect_to @profile, notice: "กู้คืนโปรไฟล์เรียบร้อยแล้ว"
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:bio)
  end
end
