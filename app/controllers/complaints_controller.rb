require "cowsay"

class ComplaintsController < ApplicationController
  # before_action :authenticate_investigator!

  def index
    @complaints = Complaint.all
  end

  def new
    @complaint = Complaint.new
  end

  def create
    params.inspect
    p "===================================="
    p params
    puts Cowsay.say user_params[:complaint]
    @user = User.new(user_params[:user])
    puts Cowsay.say @user
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

    def user_params
      params.require(:complaint).permit( user[:name] , user[:email], user[:phone])
    end
end
