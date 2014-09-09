require 'spec_helper'

feature "Create a report", %q{
  As a learner
  I want to create a report
  So that I can reflect on my learning activity
} do

  before do
    @learner = Learner.make!
    login_as @learner
  end

  scenario 'View reports' do
    click_on 'My Reports'
    expect(page.current_path).to eql(profile_reports_path)
  end

  scenario 'Successfully create a report' do
    visit profile_reports_path
    click_on 'Build Report'

    expect(page.current_path).to eql(new_profile_report_path)

    fill_in 'Where I started', with: 'I started at the bottom'
    fill_in 'Where I am now', with: "Now I'm in the middle"
    fill_in 'Where I want to be', with: 'At the top'
    fill_in 'Teacher comment', with: "Head in the clouds"

    expect {
      click_on 'Save'  
    }.to change { Report.count }.by(1)    

    expect(page.current_path).to eql profile_reports_path
  end

  scenario 'Successfully edit a report' do
    @report = Report.make!(learner: @learner)

    visit profile_reports_path
    click_on @report.decorate.name

    about_me = 'about_me'

    fill_in 'About me', with: about_me

    expect {
      click_on 'Save'
    }.to change { Report.count }.by 0

    expect(@report.reload.about_me).to eql about_me
    expect(page.current_path).to eql profile_reports_path
  end

  scenario 'Cancel Editing a Report' do
    @report = Report.make!(learner: @learner)

    visit profile_reports_path
    click_on @report.decorate.name

    about_me = 'about_me'

    fill_in 'About me', with: about_me
    
    click_on 'Cancel'
    expect(page.current_path).to eql profile_reports_path
  end

end