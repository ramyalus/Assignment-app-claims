class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_employee, only: [:update, :show, :destroy, :edit]

  def index
    @employees = current_user.employees.paginate(page: params[:page], per_page: 10)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to company_path(@employee.company), notice: "Employee has been created successfully."
    else
      render action: 'new'
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to company_path(@employee.company), notice: "Employee details has been updated successfully." 
    else
      render action: 'edit' 
    end
  end

  def show
    @reimbursements = @employee.reimbursements.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def destroy
    if @employee.destroy!
      flash[:notice] = "Employee deleted successfully."
    else
      flash[:alert] = "Unable to delete company"
    end
    redirect_to company_path(@employee.company)
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :qualification, :age, :designation, :email, :company_id, :date_of_birth)
  end

  def find_employee
    @employee = Employee.find(params[:id])
  end
end
