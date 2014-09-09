require 'spec_helper'

feature "Marking a tracker as done", %q{
  In order to indicate completion
  As a learner
  I want to mark a tracker as done
} do

  context 'Logged in learner' do
    before do
      @learner = Learner.make!
      login_as @learner
    end

    scenario 'Mark a tracker as done with the same name as the tracker' do
      tracker_name = 'Write a letter of the alphabet'
      Focus.make!(name: 'Empathy')
      Subject.make!(name: 'Music')
      # create a new tracker
      visit new_tracker_path
      fill_in 'Name', with: tracker_name
      select 'Empathy', from: 'Focus'
      select 'Music', from: 'Subject'
      click_on 'tracker_save'
      expect(page.current_path).to eql(dashboard_path)

      click_link tracker_name
      fill_in 'Description', with: 'Achievement description'
      click_button 'Done'

      expect(page.current_path).to eql(dashboard_path)
      expect(page).to have_css '.achievements li h2', text: tracker_name
      expect(Achievement.find_by_name(tracker_name).tracker).not_to be_nil
      expect(Achievement.find_by_name(tracker_name).tracker.name).to eq(tracker_name)

      expect(Achievement.find_by_name(tracker_name).focus).not_to be_nil
      expect(Achievement.find_by_name(tracker_name).focus.name).to eq('Empathy')

      expect(Achievement.find_by_name(tracker_name).subject).not_to be_nil
      expect(Achievement.find_by_name(tracker_name).subject.name).to eq('Music')
    end
  end
end

feature 'Achievement focus' do
  before do
    @learner = Learner.make!
    login_as @learner
  end

  context 'with a focus assigned to the tracker' do
    before do
      @focus = Focus.make!
      @tracker = Tracker.make!(learner: @learner, focus: @focus)
    end

    scenario 'when completing a tracker' do
      visit dashboard_path
      click_on @tracker.name
      fill_in 'Description', with: 'Achievement description'
      click_on 'Done'
      
      expect(page.current_path).to eql(dashboard_path)
    end
    
  end
  
end
