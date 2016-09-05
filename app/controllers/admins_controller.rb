require "cowsay"
 class AdminsController < Devise::InvestigatorsController

  before_filter :authenticate_investigator!

  def index
  end

  def new
    super
  end

  def create
    #new logic here
  end

  def update
    super
  end

  # private

end
