require 'spec_helper'

feature "Component Guide - keeps design consistent across the app" do
  # component library should be accessible without login (no personal data displayed)
  context 'Not logged in' do

    scenario "Validate HTML Markup" do
      visit components_path
      expect(page.current_path).to eql(components_path)
      expect(page).to be_valid_markup
    end
  end
end
