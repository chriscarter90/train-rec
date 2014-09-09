shared_examples "access denied" do |path|
  scenario "when not logged in" do
    visit send(path)

    expect(page).to have_content "Log In"
    expect(current_path).to eq(login_path)
  end
end
