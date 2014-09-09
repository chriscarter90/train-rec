require 'spec_helper'

feature "In order to have a landing page, a dashboard page should exist that will function as the homepage" do
  context 'Not logged in' do
    it_behaves_like "access denied", :dashboard_path
  end

  context 'Logged in learner' do
    before do
      @learner = Learner.make!
      login_as @learner
    end

    background do
      Achievement.create!(description: "Won the house cup", learner: @learner, created_at: 3.days.ago)
      Achievement.create!(description: "Quidditch MVP", learner: @learner, created_at: 2.days.ago)
      Tracker.create!(name: "Moon shot", learner: @learner, created_at: 3.days.ago)
      Tracker.create!(name: "Mission to Mars", learner: @learner, created_at: 2.days.ago)
    end

    scenario 'Dashboard' do
      visit root_path
      expect(page.current_path).to eql(dashboard_path)
      expect(page).to be_valid_markup

      # A list of trackers should be rendered in descending order of creation
      within ".achievements" do
        # expect(page).to have_css("h1", text: "Achievements")
        # expect(page).to have_css(".count", text: "2") # count removed
        expect(page).to have_css("ul li:nth-child(1) p", text: "Quidditch MVP")
        expect(page).to have_css("ul li:nth-child(2) p", text: "Won the house cup")
      end

      # A list of trackers should be rendered in descending order of creation
      within ".trackers" do
        expect(page).to have_css("h1", "Trackers")
        expect(page).to have_css(".count", text: "2")
        expect(page).to have_css("ul li:nth-child(1) a", text: "Mission to Mars")
        expect(page).to have_css("ul li:nth-child(2) a", text: "Moon shot")
      end

    end

    scenario "Creating a tracker from the dashboard" do
      visit root_path
      within '#sidebar' do
        click_link 'Add'
      end

      expect(page.current_path).to eql(new_tracker_path)
    end

    scenario "Creating an achievement from the dashboard (inline form)" do
      visit root_path
      fill_in 'achievement_description', :with => 'Who said it could not be done...?'

      click_on('achievement_save') # saves our new achievement
      expect(page.current_path).to eql(dashboard_path)

      within ".achievements" do
        expect(page).to have_css("ul li:nth-child(1) p", text: "Who said it could not be done...?")
      end


    end

    scenario "Viewing the full profile" do
      visit root_path
      click_on 'My Profile'

      expect(page.current_path).to eql(profile_path)
    end
  end
end

feature "Edit an Achievement" do

  context 'Logged in learner' do
    before do
      @learner = Learner.make!
      login_as @learner
    end

    scenario "Edit/Update an Achievement" do
      visit root_path
      initial_description = "Imaginative Achievement description here"
      updated_description = "My Awesome new description"

      fill_in 'achievement_description', :with => initial_description
      click_on('achievement_save')


      within ".achievements ul li:nth-child(1)" do 
        expect(page).to have_css("p", text: "Imaginative Achievement description here")
        click_link 'Edit'
        find(:css, "textarea.description").set(updated_description)
        click_button 'Update'
      end

      visit dashboard_path
      within ".achievements" do
        expect(page).to have_css("ul li:nth-child(1) p", text: updated_description)
      end

    end

  end
end

feature "Filter achievements by focus", %q{
  In order to reflect on specific areas of my activity
  As a learner
   want to filter the achievements in my dashboard by focus
} do

  before do
    @learner = Learner.make!

    @communication = Focus.make!(name: 'Communication')
    @empathy = Focus.make!(name: 'Empathy')

    @communication_achievement = Achievement.make!(learner: @learner, focus: @communication, name: 'communication')
    @empathy_achievement = Achievement.make!(learner: @learner, focus: @empathy, name: 'empathy')
    
    login_as @learner
  end

  scenario 'Filter empathy achievements', js: true do
    visit dashboard_path

    expect(page).to have_select("Filter", selected: 'Show all')
    expect(page).to have_content @communication_achievement.name
    expect(page).to have_content @empathy_achievement.name
    
    select 'Empathy', from: 'Filter'

    expect(page).to have_content @empathy_achievement.name
    expect(page).to_not have_content @communication_achievement.name
    expect(page).to have_select("Filter", selected: 'Empathy')

    select 'Show all', from: 'Filter'
    
    expect(page).to have_select("Filter", selected: 'Show all')
    expect(page).to have_content @communication_achievement.name
    expect(page).to have_content @empathy_achievement.name
  end
end
