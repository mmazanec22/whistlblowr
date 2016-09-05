require "cowsay"

class NewInvestigatorsController < ApplicationController

  def new
  end

  def create
    if current_investigator.admin?
      @email = params[:email]
      @investigator = Investigator.new(email: @email, password: "secretsix")
      if @investigator.save
        @errors = ["user saved"]
        render 'new_investigators/new'
      else
        @errors = ["user NOT saved"]
        render 'new_investigators/new'
      end
    else
      @errors = ["you are not authorized"]
      render "new"
    end
  end

end
