require "cowsay"
require 'rails_helper'

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
    @complaint = Complaint.new(complaint_params)
    @complaint.user = return_user
    @complaint.save
    flash.now[:notice] = @complaint.key
    render 'show'
  end

  def show
    @complaint = Complaint.find_by(key: params[:complaint_key])
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

    def user_params
      params.require(:complaint).permit(user: [:name, :email, :phone])
    end
end
