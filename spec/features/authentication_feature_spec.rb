require 'spec_helper'

feature "Authencticate as a learner", %q{
In order to can gain access
As a learner
I want to authenticate myself
} do
  scenario 'Logging in as a learner with a set tracker' do
    missp = Learner.make!
    kermit = Learner.make!(name: "Kermit the Frog")
    Tracker.make!(:learner => missp, :name => "Impress Kermy")
    tracker = Tracker.make!(:learner => kermit, :name => "Turn down Miss Piggy")
    Achievement.make!(:learner => missp, :name => "Baked cake for Kermy")
    achievement = Achievement.make!(:learner => kermit, :name => "Threw away cake")
    login_as kermit

    visit dashboard_path
    expect(page).to have_content('Turn down Miss Piggy')
    expect(page).not_to have_content('Impress Kermy')
    expect(page).to have_content('Threw away cake')
    expect(page).not_to have_content('Baked cake for Kermy')
    expect(page).to have_content('Kermit the Frog')
  end
end
