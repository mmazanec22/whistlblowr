require 'rails_helper'
require 'capybara/rails'

feature "complaint form" do
  scenario "user sees complaint form" do
    visit "/"
    within(first('h5')) do
      expect(page).to have_content "Complaint"
    end
  end
end
