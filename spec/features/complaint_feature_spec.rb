require 'rails_helper'
require 'capybara/rails'

feature "complaint form" do
  scenario "user sees complaint form" do
    visit "complaints/new"
    within('h2') do
      expect(page).to have_content "Complaint"
    end
  end
end
