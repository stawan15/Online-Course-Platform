class UsersController < ApplicationController
  load_and_authorize_resource except: [ :restore ]

  def destroy
    if @user.destroy
      redirect_back fallback_location: root_path, notice: "ลบผู้ใช้งานเรียบร้อยแล้ว", status: :see_other
    else
      redirect_back fallback_location: root_path, alert: "ไม่สามารถลบผู้ใช้งานได้", status: :see_other
    end
  end

  def restore
    @user = User.only_deleted.find(params[:id])
    authorize! :restore, @user

    if @user.restore
      redirect_back fallback_location: root_path, notice: "กู้คืนผู้ใช้งานเรียบร้อยแล้ว", status: :see_other
    else
      redirect_back fallback_location: root_path, alert: "ไม่สามารถกู้คืนผู้ใช้งานได้", status: :see_other
    end
  end
end
