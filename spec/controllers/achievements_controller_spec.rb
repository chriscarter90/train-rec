require 'spec_helper'

describe AchievementsController do
  before do
    @user = Learner.make!
    sign_in @user
  end

  describe "POST #create" do
    let(:achievement_attributes) { Achievement.make.attributes.except("id", "created_at", "updated_at", "learner_id") }

    it "assigns a user to the created achievement" do
      post :create, achievement: achievement_attributes

      expect(assigns(:achievement).errors.full_messages).to eql([])
      expect(assigns(:achievement)).to be_persisted
      expect(assigns(:achievement).learner).to eql(@user)
    end

    it 'assigns a focus to the created achievement' do
      focus = Focus.make!
      post :create, achievement: achievement_attributes.merge(focus_id: focus.id)

      expect(assigns(:achievement).focus).to eq(focus)
    end

    it 'assigns a subject to the created achievement' do
      subject = Subject.make!
      post :create, achievement: achievement_attributes.merge(subject_id: subject.id)

      expect(assigns(:achievement).subject).to eq(subject)
    end

    it "redirects to the dashboard" do
      post :create, achievement: achievement_attributes
      expect(request).to redirect_to(dashboard_path)
    end
  end

  describe "GET #new" do
    context "nested under a tracker" do
      let(:tracker) { Tracker.make!(learner: @user, name: 'Find a squirrel') }

      it "uses the tracker's name as its default" do
        get :new, tracker_id: tracker.to_param
        expect(assigns[:achievement].name).to eq 'Find a squirrel'
      end

      it "does not use the tracker's name if it already has one" do
        get :new, tracker_id: tracker.to_param, achievement: { name: 'Found a red tail squirrel'}
        expect(assigns[:achievement].name).to eq 'Found a red tail squirrel'
      end

      it "uses the tracker's focus" do
        focus = Focus.make!
        tracker.update_attributes!(focus_id: focus.id)
        get :new, tracker_id: tracker.to_param
        expect(assigns(:achievement).focus).to eq(focus)
      end

      it "uses the tracker's subject" do
        subject = Subject.make!
        tracker.update_attributes!(subject_id: subject.id)
        get :new, tracker_id: tracker.to_param
        expect(assigns(:achievement).subject).to eq(subject)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @achievement = Achievement.make!(learner: @user)
    end

    it "soft trashes the achievement" do
      delete :destroy, id: @achievement
      
      expect(Achievement.find_by_id(@achievement.id)).to be_nil
      expect(Achievement.trashed.find_by_id(@achievement.id)).to eql(@achievement)
    end

    context 'as JS' do
      it 'destroys the achievement' do
        expect {
          xhr :delete, :destroy, id: @achievement
        }.to change { Achievement.count }.by(-1)        
      end

      it 'responds with 200' do
        xhr :delete, :destroy, id: @achievement
        expect(response.response_code).to eql 200
      end
    end
  end
end
 
