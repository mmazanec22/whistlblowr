require "cowsay"

class NewInvestigatorsController < ApplicationController

  before_action :confirm_admin, :load_investigators

  def new
    # @investigators = Investigator.order(:created_at)
  end

  def create
    email = params[:email]
    @investigator = Investigator.new(email: email, password: Devise.friendly_token.first(8))
    if @investigator.save
      UserMailer.new_investigator_email(@investigator.email, @investigator.password).deliver
      @errors = ["User saved successfully."]
      redirect_to '/investigator_admin', :flash => { :errors => @errors }
    else
      @errors = ["User NOT saved.  Is this e-mail address already in use?"]
      redirect_to '/investigator_admin', :flash => { :errors => @errors }
    end
  end

  def update
    if @investigator.admin && @investigators.where(admin: true).count > 2 && @investigator != current_investigator
      @investigator.admin = false
    elsif @investigator.admin
      @errors = ["At least two administrators are required."]
    else
      @investigator.admin = true
    end

    @investigator.save
    redirect_to '/investigator_admin', :flash => { :errors => @errors }
  end

  def delete
    if @investigator != current_investigator && @investigators.where(admin: true).count >= 2
      if @investigator.admin == true && @investigators.where(admin: true).count == 2
        @errors = ["At least two administrators are required."]
      else
        @investigator.destroy
      end
    else @investigator.admin
      @errors = ["At least two administrators are required."]
    end
    redirect_to '/investigator_admin', :flash => { :errors => @errors }
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
