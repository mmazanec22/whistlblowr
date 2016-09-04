require "cowsay"
require_relative "../uploaders/media_uploader"

class ComplaintsController < ApplicationController
  # before_action :authenticate_investigator!, except: [:new, :show, create]

  def index
    @complaints = Complaint.all
  end

  def new
    @complaint = Complaint.new
    allegation =  Allegation.new
    @complaint.allegations << allegation
    @allegations = @complaint.allegations
  end

  def create
    @message = Message.new
    @complaint = Complaint.new(complaint_params)
    @complaint.user = return_user
    if @complaint.save
      flash[:notice] = @complaint.key
      redirect_to complaints_find_path(:complaint_key => @complaint.key)
    else
      @errors = @complaint.errors.full_messages
      render "new"
    end
  end

  def show
    @message = Message.new
    @complaint = @complaint ? @complaint : Complaint.find_by(key: params[:complaint_key])
  end

  def edit
    @complaint = Complaint.find_by(key: params[:complaint_key])
  end

  def update
    @complaint = Complaint.find_by(key: params[:complaint_key])
    @complaint.status = params[:status]
    @complaint.save
    if request.xhr?
      "done"
    else
      redirect_to complaints_path
    end
  end

  def delete

  end

  private

    def complaint_params
      params.require(:complaint).permit(:content, {media: []})
    end

    def return_user
      up = user_params[:user]
      User.find_or_create_by(up)
    end

    def user_params
      params.require(:complaint).permit(user: [:name, :email, :phone])
    end
end
