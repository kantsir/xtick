class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  def index
    @staffs = Staff.all
  end

  def show
  end

  def edit
  end

  def update
    is_approved = staff_params[:approved]=='0' ? false : true

    if is_approved != @staff.approved
       XTickMailer.user_approved(@staff) if is_approved
       XTickMailer.user_access_denied(@staff) unless is_approved
    end

    return redirect_to staffs_path, notice: 'Profile was successfully updated.' if @staff.update(staff_params)
    render action: 'edit'
  end

  private
  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(:name, :approved)
  end
end
