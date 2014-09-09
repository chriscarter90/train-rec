require 'spec_helper'

# We need a controller that inherits from ApplicationController
# to test its functionality.
class TestApplicationController < ApplicationController
  def index
    render text: 'foo'
  end
end

describe TestApplicationController do
  
  before :all do
    Progress360::Application.routes.draw do
      get 'login', to: 'sessions#new', as: 'login'
      get '/testing-application-controller' => 'test_application#index'
    end
  end
  
  after :all do
    Progress360::Application.reload_routes!
  end

  describe 'authorization' do
    let(:learner) { Learner.make }

    before do
      Learner.stub(:find).with(13).and_return learner
    end
    
    it 'redirects to the login page when not logged in' do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it 'does not redirect when logged in' do
      session[:learner_id] = 13
      get :index
      expect(response).not_to redirect_to(login_path)
    end

    it 'assigns the learner to @current_user when logged in' do
      session[:learner_id] = 13
      get :index
      expect(assigns[:current_user].object).to eql(learner)
      expect(controller.send(:current_user).object).to eql(learner)
    end

    it 'assigns nil to @current_user when not logged in' do
      get :index
      expect(assigns[:current_user]).to be_nil
      expect(controller.send(:current_user)).to be_nil
    end
  end
end
