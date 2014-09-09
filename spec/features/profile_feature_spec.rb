require 'spec_helper'

feature "As a learner I want a profile so that a Teacher can get a better understanding of me" do
  context "Not logged in" do
    it_behaves_like "access denied", :profile_path
  end

  context "Logged in" do
    background do
      @learner = Learner.make!(name: "Bob Bobson")
      login_as @learner
    end

    scenario "Viewing my profile" do
      visit profile_path

      have_profile_item('Name', 'Bob Bobson')
      click_link "Go back"
      expect(page.current_path).to eql(dashboard_path)
    end

    scenario "Editing my profile" do
      visit profile_path
      click_link "Edit profile"

      expect(page.current_path).to eql(edit_profile_path)

      have_profile_item('Name', 'Bob Bobson')

      fill_in "Name", with: "Roberta Bobson"
      fill_in "Age", with: "14"
      fill_in "Class", with: "9C"
      fill_in "About me", with: "Totes McCool"
      fill_in "About me as a learner", with: "I work well under pressure"
      fill_in "My hobbies and interests", with: "Keeping it real"
      fill_in "My big ambitions", with: "Supreme Chancellor of the Universe"
      fill_in "3 favourite things", with: "Cake, My little pony, Biscuits"
      fill_in "Best thing this week", with: "Getting my Xbox One"

      click_button "Save"

      have_profile_item('Name', 'Roberta Bobson')
      have_profile_item('Age', '14')
      have_profile_item('Class', '9C')
      # have_profile_section('About me', 'Totes McCool')
      expect(page).to have_content 'Totes McCool'
      have_profile_section('About me as a learner', 'I work well under pressure')
      have_profile_section('My hobbies and interests', "Keeping it real")
      have_profile_section('My big ambitions', 'Supreme Chancellor of the Universe')
      have_profile_section('3 favourite things', 'Cake, My little pony, Biscuits')
      have_profile_section('Best thing this week', 'Getting my Xbox One')
    end

    scenario 'Upload an avatar' do
      visit edit_profile_path
      expect(page).to have_selector("input[type=file]")
      
      attach_file('learner_avatar', File.join(Rails.root, 'app', 'assets', 'images', 'chevrons_orange.png'))
      click_button "Save"
      
      expect(page).to have_xpath "//img[contains(@src, 'chevrons_orange.png')]"
    end

    context 'with an avatar' do
      before do
        avatar = File.join(Rails.root, 'app', 'assets', 'images', 'chevrons_orange.png')
        @learner.avatar = File.open(avatar)
        @learner.save
      end

      scenario 'View dashboard' do
        visit dashboard_path
        expect(page).to have_xpath "//img[contains(@src, 'chevrons_orange.png')]"
      end
    end

    context 'without an avatar' do
      scenario 'View dashboard' do
        visit dashboard_path
        expect(page).to have_xpath "//img[contains(@src, 'default_avatar.png')]"
      end
    end

    scenario "Log out of app" do
      visit root_path
      find("#logout").click
      expect(page.current_path).to eql('/login')
    end

  end

  def have_profile_item(name, value)
    expect(page).to have_xpath "//dt[.='%s']/following-sibling::dd[1][.='%s']" % [name, value]
  end

  def have_profile_section (heading, contents)
    expect(page).to have_xpath "//section[h2='%s'][contains(p, '%s')]" % [heading, contents]
  end

end