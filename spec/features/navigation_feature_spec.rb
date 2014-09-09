require 'spec_helper'

feature "Global Navigation" do
  context 'Not logged in' do
    it_behaves_like "access denied", :dashboard_path
  end

  context 'Logged in learner' do
    before do
      @learner = Learner.make!
      login_as @learner
    end

    scenario 'Click on My Profile link in #nav takes us to /learner' do
      visit root_path
      within '#nav' do
        click_link 'My Profile'
      end
      expect(page.current_path).to eql(profile_path)
    end

    scenario 'Click on My Activities and Achievements link in #nav goes to /dashboard' do
      visit root_path
      within '#nav' do
        click_link 'My Activities and Achievements'
      end
      expect(page.current_path).to eql(dashboard_path)
    end

    scenario 'Click on Logout in #nav goes to /login' do
      visit root_path
      within '#nav' do
        click_link 'Logout'
      end
      expect(page.current_path).to eql(login_path)
    end
  end
end