require 'spec_helper'

describe TrackersController do
  let(:user) { Learner.make! }

  before do
    sign_in user
  end

  describe "collection" do
    it "decorates the trackers" do
      Tracker.make!(learner: user)
      expect(controller.send(:collection).first).to be_decorated_with TrackerDecorator
    end
  end

  describe 'GET #new' do
    it 'decorates the resource' do
      get :new
      expect(assigns(:tracker)).to be_decorated
    end
  end
  
  describe "POST #create" do
    let(:tracker_attributes) { Tracker.make.attributes.except("id", "created_at", "updated_at", "learner_id") }

    it "assigns a user to the created tracker" do
      post :create, tracker: tracker_attributes

      expect(assigns(:tracker).errors.full_messages).to eql([])
      expect(assigns(:tracker)).to be_persisted
      expect(assigns(:tracker).learner).to eql(user)
    end

    it "redirects to the dashboard" do
      post :create, tracker: tracker_attributes

      expect(request).to redirect_to(dashboard_path)
    end
  end

  describe "DELETE #destroy" do
    let(:tracker) { Tracker.make!(learner: user) }

    it "soft trashes the tracker" do
      delete :destroy, id: tracker.id
      expect(Tracker.find_by_id(tracker.id)).to be_nil
      expect(Tracker.trashed.find_by_id(tracker.id)).to eql(tracker)
    end

    it "redirects to the dashboard" do
      delete :destroy, id: tracker.id
      expect(request).to redirect_to(dashboard_path)
    end
  end
end
