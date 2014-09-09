require 'spec_helper'

feature "Create an tracker", %q{
  In order to log specific achievements
  As a learner
  I want to create a tracker
} do

  context 'Logged in learner' do
    before do
      @learner = Learner.make!
      login_as @learner

      Focus.make!(name: "Communication")
      Focus.make!(name: "Empathy")

      Subject.make!(name: "Math")
      Subject.make!(name: "Music")
    end

    scenario 'Create a first tracker' do
      name = 'Ask a question in class'
      visit new_tracker_path
      fill_in 'Name', with: name
      select 'Communication', from: 'Focus'
      select 'Music', from: 'Subject'
      click_on 'tracker_save'

      expect(page.current_path).to eql(dashboard_path)
      expect(page).to have_css '.trackers li a', text: name

      click_on name
      expect(page).to have_css '.tracker .focus', text: "Communication"
      expect(page).to have_css '.tracker .subject', text: "Music"
    end

    scenario 'Unsuccessfully create a tracker' do
      name = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

      visit new_tracker_path
      fill_in 'Name', with: name
      click_on 'Set Tracker'

      expect(page).to have_content '1 error prohibited this record from being saved'
      expect(page).to have_content "Name is too long"
    end

    scenario 'Create a tracker with no focus or subject' do
      name = 'Ask a question in class'
      visit new_tracker_path
      fill_in 'Name', with: name
      click_on 'tracker_save'

      expect(page.current_path).to eql(dashboard_path)

      click_on name
      expect(page).to have_css '.tracker .focus', text: "General"
      expect(page).not_to have_css '.tracker .subject'
    end

    scenario 'Unsuccessfully create a tracker' do
      name = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

      visit new_tracker_path
      fill_in 'Name', with: name
      click_on 'Set Tracker'

      expect(page).to have_content '1 error prohibited this record from being saved'
      expect(page).to have_content "Name is too long"
    end

    scenario "Click cancel from new tracker re-directs to dashboard_path" do
      visit new_tracker_path
      # don't do anything on the form just click cancel
      click_on 'tracker_cancel'
      expect(page.current_path).to eql(dashboard_path)
    end

    scenario 'Delete a tracker' do
      Tracker.make!(:learner => @learner, :name => "Stroke a cat")

      visit dashboard_path
      expect(page).to have_content('Stroke a cat')
      click_on 'Stroke a cat'
      click_button("Archive Tracker")

      expect(page.current_path).to eql(dashboard_path)
      expect(page).not_to have_content('Stroke a cat')
      expect(Tracker.trashed.find_by_name('Stroke a cat')).not_to be_nil
    end
  end
end

feature "Indicate level of tracker", %q{
  As a learner 
  I want to indicate the level of difficulty when I create a tracker
  So that I can set different types of tracker
} do

  let(:name) { 'Ask a question in class' }

  before do
    @learner = Learner.make!
    login_as @learner
  end

  scenario "Successfully set tracker difficulty" do
    visit new_tracker_path
    expect(page).to have_select('How difficult is it?', selected: 'Medium')

    fill_in 'Name', with: name
    select 'Hard', from: 'How difficult is it?'
    click_button 'Set Tracker'
    
    expect(Tracker.find_by_name(name).difficulty).to eq "hard"
  end

end
