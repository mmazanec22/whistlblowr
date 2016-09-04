require "cowsay"
 class InvestigatorController < ApplicationController

  def new
    @investigator = Investigator.new
  end

  def create
    #new logic here
  end

  def update
    super
  end

  # private

end
