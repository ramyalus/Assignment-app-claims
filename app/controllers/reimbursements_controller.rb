class ReimbursementsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reimbursement, only: [:update, :show, :destroy, :edit, :download]
  skip_before_action :verify_authenticity_token, only: :download
  def index
    @reimbursements = Reimbursement.includes(:employee, :company).where(employee: {user_id: current_user.id}).paginate(page: params[:page], per_page: 10)
  end

  def new
    @reimbursement = Reimbursement.new
  end

  def create
    reimbursement = Reimbursement.new(reimbursement_params)
    if reimbursement.save
      redirect_to reimbursements_path, notice: "Reimbursement created successfully"
    else
      render action: 'new'
    end
  end

  def update
    if @reimbursement.update(reimbursement_params)
      redirect_to reimbursements_path, notice: "Reimbursement has been updated successfully." 
    else
      render action: 'edit' 
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if @reimbursement.destroy!
      flash[:notice] = "Reimbursement deleted successfully."
    else
      flash[:alert] = "Unable to delete Reimbursement"
    end
    redirect_to company_path(@reimbursement.company)
  end

  def download
    #TODO
    # rails_blob_path(@reimbursement.receipt, disposition: "attachment")
    # url = @reimbursement.receipt.url
    # redirect_to url
    # data = open(url) 
    # send_data data.read, filename: "NAME YOU WANT.pdf", type: "application/pdf", disposition: 'inline', stream: 'true', buffer_size: '4096' 
    # s3 = Aws::S3::Resource.new(
    #   region: 'us-east-1',
    #   access_key_id: "",
    #   secret_access_key: ""
    # )
    # s3.bucket('rails-active-storage-claims').object('key').download_file(url)
  end

  private
  def reimbursement_params
    params.require(:reimbursement).permit(:purpose, :amount, :date_of_expenditure, :company_id, :employee_id, :receipt)
  end

  def find_reimbursement
    @reimbursement = Reimbursement.find(params[:id])
  end
end
