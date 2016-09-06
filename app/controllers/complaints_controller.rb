require "cowsay"
require_relative "../uploaders/media_uploader"

class ComplaintsController < ApplicationController
  before_action :authenticate_investigator!, except: [:new, :show, :create]

  def index
    @complaints = Complaint.all.sort { |a,b| b.created_at <=> a.created_at }
  end

  def new
    @complaint = Complaint.new
    allegation =  Allegation.new
    @complaint.allegations << allegation
    @allegations = @complaint.allegations
    @allegations_list = AllegationType.all
  end

  def create
    @message = Message.new
    @complaint = Complaint.new(complaint_params)
    @complaint.user = return_user
    # add_allegation_types
    if @complaint.save
      flash[:notice] = @complaint.key
      flash[:message] = @complaint.content
      redirect_to complaints_find_path(:complaint_key => @complaint.key)
    else
      @errors = @complaint.errors.full_messages
      render "new"
    end
  end

  def show
    @investigator_authenticated = false
    @investigator_authenticated = true if current_investigator
    @message = Message.new
    @complaint = @complaint ? @complaint : Complaint.find_by(key: params[:complaint_key])
  end

  def edit
    @complaint = Complaint.find_by(key: params[:complaint_key])
  end

  def update
    @complaint = Complaint.find_by(key: params[:complaint_key])
    @complaint.update_attribute(:status, params[:status])
    respond_to do |format|
      format.js {render json: @complaint, status_code: "200"}
      format.html {redirect_to complaints_path}
    end
  end

  def delete

  end

  private

    # def add_allegation_types
    #   params[:complaint][:allegation_types].each do |type, value|
    #     allegation = AllegationType.find(type.to_i)
    #     @complaint.allegation_types << allegation if value.to_i == 1
    #   end
    # end

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
