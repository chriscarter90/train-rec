require 'spec_helper'

feature "Create an achievement", %q{
  In order to log specific achievements
  As a learner
  I want to create an achievement
} do

  context 'Logged in learner' do
    before do
      @learner = Learner.make!
      login_as @learner
    end

    scenario 'Create a first achievement' do
      description = 'Ask a question in class'
      visit dashboard_path
      fill_in 'achievement_description', with: description
      click_on 'achievement_save'

      expect(page.current_path).to eql(dashboard_path)
      expect(page).to have_css '.achievements li p', text: description
      # expect(Achievement.find_by_name(description)).not_to eql(nil)
    end

    scenario "Click cancel from new achievement re-directs to dashboard_path" do
      visit dashboard_path
      click_on 'achievement_cancel'
      expect(page.current_path).to eql(dashboard_path)
    end
  end
end

feature "Attach an image", %q{
  In order to provide evidence
  As a learner
  I want to attach an image to an achievement
} do

  let(:learner) { Learner.make! }
  let(:description) { 'Awesome achievement' }
  before { login_as learner }

  scenario "Successfully store image" do
    visit dashboard_path

    within '#main' do
      fill_in 'achievement_description', with: description
      attach_file('achievement[asset]', File.join(Rails.root, 'app', 'assets', 'images', 'default_avatar.png'))
      click_on 'Add'
    end

    expect(page.current_path).to eq(dashboard_path)
    expect(Achievement.find_by_description(description).asset.url).to_not be_nil    
  end

  context 'with an attached image' do
    let(:image) { File.open(File.join(Rails.root, 'app', 'assets', 'images', 'default_avatar.png')) }

    before do
      Achievement.make!(learner: learner, asset: image)
    end

    scenario 'Display image thumbnail' do
      visit dashboard_path
      expect(page).to have_xpath "//img[@class=\"img-thumbnail\"][contains(@src, 'default_avatar.png')]"
    end
  end
end

feature "Add focus to achievement", %q{
  In order to reflect on specific areas of activity on an achievement
  As a learner
  I want to add a single focus from a list of foci
} do

  let!(:focus) { Focus.make!(name: 'Empathy') }
  before { login_as Learner.make! }

  scenario 'Create an achievement with a focus' do
    visit dashboard_path

    within '.achievement-inline-form' do
      fill_in 'achievement_description', with: "Anything dream will do"
      select 'Empathy', from: 'Add focus'
      click_on 'Add'  
    end

    expect(current_path).to eq(dashboard_path)

    within '.achievements ul' do
      expect(page).to have_content focus.name  
    end
  end

  scenario 'Create an achievement without a focus' do
    visit dashboard_path

    within '.achievement-inline-form' do
      fill_in 'achievement_description', with: 'Woke up on the right side of the bed'
      click_on 'Add'  
    end

    within '.achievements ul' do
      expect(page).to have_content Focus::UNDEFINED_NAME
    end
  end
end

feature "Add subject to achievement", %q{
  In order to reflect on specific subject on an achievement
  As a learner
  I want to add a single subject from a list of subjects
} do

  let!(:subject) { Subject.make!(name: 'Math') }
  before { login_as Learner.make! }

  scenario 'Create an achievement with a subject' do
    visit dashboard_path

    within '.achievement-inline-form' do
      fill_in 'achievement_description', with: "Did a long division"
      select 'Math', from: 'Add subject'
      click_on 'Add'  
    end

    expect(current_path).to eq(dashboard_path)

    within '.achievements ul' do
      expect(page).to have_content subject.name  
    end
  end

  scenario 'Create an achievement without a subject' do
    visit dashboard_path

    within '.achievement-inline-form' do
      fill_in 'achievement_description', with: 'Read about complex numbers'
      click_on 'Add'  
    end
  end
end

feature 'Delete an achievement' do
  before do
    @learner = Learner.make!
    @achievement = Achievement.make!(learner: @learner)

    login_as @learner
  end

  scenario 'Successfully delete an achievement' do
    visit dashboard_path
    
    within '.activity' do
      click_on 'Delete'
    end
    
    expect(page).to_not have_content @achievement.name
  end
end
