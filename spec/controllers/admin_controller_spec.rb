require 'spec_helper'

describe AdminController do

  describe 'GET #show' do
    context 'as an admin' do
      before do
        admin_login  
      end

      it 'returns http success' do
        get :show
        expect(response).to be_success
      end
    end

    context 'as a non admin' do
      it 'returns http 410' do
        get :show
        expect(response.response_code).to eql 401
      end
    end
  end

end