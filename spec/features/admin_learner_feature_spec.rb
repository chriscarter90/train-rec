require 'spec_helper'

feature "Create a learner", %q{
  As a product owner
  I want access to a user admin panel 
  So that I can easily edit and create users without asking the developers
} do

  before do
    admin_login
  end

  scenario 'Successfully create learner' do
    visit admin_learners_path
    click_on 'Create learner'

    fill_in 'Name', with: 'Tony Daly'
    fill_in 'Email', with: 'tony.daly@ubxd.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'    

    expect {
      click_on 'Create Learner'
    }.to change { Learner.count }.by(1)
  end

  scenario 'Unsuccessfully create learner' do
    visit new_admin_learner_path

    fill_in 'Name', with: 'Tony Daly'
    fill_in 'Email', with: 'tony.daly@ubxd.com'

    expect {
      click_on 'Create Learner'
    }.to change { Learner.count }.by(0)
  end
end

feature 'Edit a learner' do
  before do
    admin_login
    @learner = Learner.make!
  end

  scenario 'Successfully edit a learner' do
    visit admin_learners_path
    click_on @learner.name

    expect(page.current_path).to eql edit_admin_learner_path(@learner)

    fill_in 'Name', with: 'Tony Daley'
    click_on 'Update Learner'

    expect(@learner.reload.name).to eql 'Tony Daley'
  end
end