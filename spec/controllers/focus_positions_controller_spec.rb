require 'spec_helper'

describe FocusPositionsController do
  before do
    @user = Learner.make!
    sign_in @user
  end

  describe "get #INDEX" do
    it "initializes the learner's focus positions" do
      Learner.stub(:find).with(@user.id).and_return(@user)
      @user.should_receive(:initialize_focus_positions!)
      get :index
    end
  end
end
