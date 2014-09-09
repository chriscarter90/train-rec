require 'spec_helper'

describe ReportsController do
  let(:user) { Learner.make! }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'decorates the resource' do
      get :new
      expect(assigns(:report)).to be_decorated
    end

    it 'completes about_me from the current_user' do
      about_me = double 'about_me'
      Learner.any_instance.should_receive(:about_me).and_return(about_me)

      get :new
      expect(assigns(:report).about_me).to eql about_me
    end
  end

  describe 'GET #edit' do

    before do
      Timecop.freeze(1.month.ago) do
        @old_achievement = Achievement.make!(learner: user)
        @report = Report.make!(learner: user)
      end

      @new_achievement = Achievement.make!(learner: user)
    end

    it 'only gets achievements since the report was created' do
      get :edit, id: @report.id
      
      expect(assigns(:achievements)).to include @old_achievement
      expect(assigns(:achievements)).to_not include @new_achievement
    end
  end
end