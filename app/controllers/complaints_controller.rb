class ComplaintsController < ApplicationController
  # before_action :authenticate_investigator!

  def index
    @complaints = Complaints.all
  end

  def new
    @complaint = Complaint.new
    @user = User.new

    @allegation_type = AllegationType.new
  end

  def create
    @complaint = Complaint.new()
  end

  def show

  end

  def edit

  end

  def delete

  end

  private

  def complaint_params
  end

  def allegation_type_params
  end

  def medium_params
  end

end
