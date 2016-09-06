require "cowsay"

class NewInvestigatorsController < ApplicationController

  before_action :confirm_admin

  def new
  end

  def create

    email = params[:email]
    @investigator = Investigator.new(email: email, password: "secretsix")
    if @investigator.save
      @errors = ["user saved"]
      render 'new_investigators/new'
    else
      @errors = ["user NOT saved"]
      render 'new_investigators/new'
    end
  end

  private

  def confirm_admin
    if current_investigator
      redirect_to '/' if !current_investigator.admin?
    else
      redirect_to '/'
    end
  end

end
