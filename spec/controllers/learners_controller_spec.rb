require 'spec_helper'

describe LearnersController do
  before do
    @user = Learner.make!
    sign_in @user
  end

  describe "PUT #update" do
    it "creates focus_positions_update from attributes for learner" do
      fp = FocusPosition.make!(learner: @user)
      learner_attributes = {
        "focus_positions_attributes" => {
          "0" => {"id" => fp.id.to_s, "position" => fp.position.to_s}
        }
      }

      expected_attributes = {"0"=>{"id"=>fp.to_param, "position"=>fp.position.to_s}}
      
      # controller.should_receive(:create_focus_positions_update_from_attributes).with(@user, expected_attributes )

      FocusPositionsUpdate.should_receive(:create_for_learner_with_focus_positions_attributes!).
        with(@user, expected_attributes)
      
      put :update, id: @user.to_param, learner: learner_attributes
    end
  end

  describe "#create_focus_positions_update_from_attributes" do
    
  end
end
