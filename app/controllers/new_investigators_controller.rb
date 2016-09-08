require "cowsay"

class NewInvestigatorsController < ApplicationController

  before_action :confirm_admin, :load_investigators

  def new
    # @investigators = Investigator.order(:created_at)
  end

  def create
    email = params[:email]
    @investigator = Investigator.new(email: email, password: SecureRandom.hex(4))
    if @investigator.save
      UserMailer.new_investigator_email(@investigator.email, @investigator.password).deliver
      @errors = ["user saved"]
      redirect_to '/investigator_admin'
    else
      @errors = ["user NOT saved"]
      redirect_to '/investigator_admin'
    end
  end

  def update
    if @investigator.admin && @investigators.where(admin: true).count > 1
      @investigator.admin = false
    elsif @investigator.admin
      @errors = ["At least one Investigator administrator is required."]
    else
      @investigator.admin = true
    end

    @investigator.save
    redirect_to '/investigator_admin'
  end

  def delete
    if @investigator != current_investigator &&  @investigators.where(admin: true).count > 1
      @investigator.destroy
    else @investigator.admin
      @errors = ["At least one investigator administrator is required."]
    end
    redirect_to '/investigator_admin'
  end


  private

  def confirm_admin
    if current_investigator
      redirect_to '/' if !current_investigator.admin?
    else
      redirect_to '/'
    end
  end

  def load_investigators
    @investigators = Investigator.order(:created_at)
    if params[:id]
      @investigator = Investigator.find_by(id: params[:id])
    end
  end

end
