require "cowsay"
require_relative "../uploaders/media_uploader"

class ComplaintsController < ApplicationController
  # before_action :authenticate_investigator!

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
    puts Cowsay.say(complaint_params)
    @complaint = Complaint.new(complaint_params)
    @complaint.user = return_user
    puts @complaint.save
    binding.pry
  end

  def show

  end

  def edit

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

    def allegation_type_params
    end

    def medium_params
    end

    def user_params
      params.require(:complaint).permit(user: [:name, :email, :phone])
    end
end
