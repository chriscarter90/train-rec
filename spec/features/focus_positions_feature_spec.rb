require 'spec_helper'

feature "As a learner I want to indicate where I am against each area of focus so I can consider which I should concentrate on" do
  context "Not logged in" do
    it_behaves_like "access denied", :profile_focus_positions_path
  end

  context "Logged in" do
    background do
      Focus.make! name: "Communication"
      Focus.make! name: "Empathy"
      
      @learner = Learner.make!(name: "Bob Bobson")
      login_as @learner
    end

    scenario "learner sets her focus positions for the first time" do
      visit profile_path
      click_link "Focus areas"

      expect(find_field('Communication').value).to eq FocusPosition::DEFAULT_POSITION.to_s
      expect(find_field('Empathy').value).to eq FocusPosition::DEFAULT_POSITION.to_s
      
      fill_in "Communication", with: 0.8
      fill_in "Empathy", with: 0.2

      click_button "Save"
      
      expect(page.current_path).to eql(profile_path)
      click_link "Focus areas"

      expect(find_field('Communication').value).to eq "0.8"
      expect(find_field('Empathy').value).to eq "0.2"

      updates = @learner.focus_positions_updates
      empathy_focus_position = @learner.focus_positions.find_by_focus_id(Focus.find_by_name("Empathy").id)
      expect(updates.size).to eq 1
      expect(updates.first.data[empathy_focus_position.id]).to eq 0.2
    end

    scenario "learner cancels setting focus positions" do
      visit profile_path
      click_link "Focus areas"

      fill_in "Empathy", with: 0.7
      click_link "Cancel"

      expect(page.current_path).to eql(profile_path)
      click_link "Focus areas"
      expect(find_field('Empathy').value).to eq FocusPosition::DEFAULT_POSITION.to_s
    end
  end
end
