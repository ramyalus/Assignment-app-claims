class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_company, only: [:update, :show, :destroy, :edit, :employees]
  skip_before_action :verify_authenticity_token, only: :employees

  def index
    @companies = current_user.companies.includes(:employees, :reimbursements).paginate(page: params[:page], per_page: 10)
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user_id = current_user.id
    if @company.save
      flash[:notice] = "Successfully Created Company."
      redirect_to companies_path 
    else
      render action: 'new' 
    end
  end

  def update
    if @company.update(company_params)
      flash[:notice] = "Successfully Updated."
      redirect_to companies_path 
    else
      render action: 'edit' 
    end
  end

  def show
    @employees = @company.employees.includes(:reimbursements).paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def destroy
    if @company.destroy!
      flash[:notice] = "Successfully Deleted."
      redirect_to companies_path
    else
      flash[:alert] = "Unable to delete company"
      redirect_to companies_path
    end
  end

  def employees
    render json: @company.employees
  end

  private
  def company_params
    params.require(:company).permit(:company_name, :user_id, :description)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end
