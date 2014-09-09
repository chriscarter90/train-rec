require 'spec_helper'

describe SessionsController do
  describe "POST #create" do
    let(:learner) { Learner.make!(email: "valid@example.com", password: "valid", password_confirmation: "valid") }

    it "sets the learner id in the session if log in details are valid" do
      post :create, email: learner.email, password: "valid"
      expect(session[:learner_id]).to eql(learner.id)
    end

    it "clears the learner id in the session if log in details are not valid" do
      post :create, email: learner.email, password: "wrong"
      expect(session[:learner_id]).to be_nil
    end
  end
end
