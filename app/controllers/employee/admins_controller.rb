class Employee::AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin, only: %i[show edit update destroy]

  def index
    @admins = Admin.all
  end

  def show
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to employee_admin_path(@admin), notice: t('.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    @admin.update(admin_params)
    redirect_to employee_admin_path(@admin), notice: t('.success')
  end

  def destroy
    @admin.destroy
    redirect_to employee_admins_path, notice: t('.success')
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :occupation, :password)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
