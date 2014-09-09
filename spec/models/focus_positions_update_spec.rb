require 'spec_helper'

describe FocusPositionsUpdate do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FocusPositionsUpdate.make).to be_valid
    end

    it 'requires a learner' do
      expect(FocusPositionsUpdate.make(:learner => nil)).not_to be_valid
    end
  end

  describe 'data' do
    it 'can be used as a hash' do
      fpu = FocusPositionsUpdate.make!(data: { "foo" => "bla" })
      expect(fpu.data["foo"]).to eq "bla"
    end
  end

  describe ".create_for_learner_with_focus_positions_attributes!" do
    let(:learner) { Learner.make! }
    
    it "creates a FocusPositionsUpdate with the learner" do
      fpu = FocusPositionsUpdate.create_for_learner_with_focus_positions_attributes!(learner, {})
      expect(fpu.learner).to eq learner
    end
    
    it "creates a FocusPositionsUpdate with empty data if learner has no FocusPositions if learner has no FocusPositions" do
      fpu = FocusPositionsUpdate.create_for_learner_with_focus_positions_attributes!(learner, {})
      expect(fpu.data).to be_empty
    end

    it "stores a position for each focus_position" do
      attributes =
      {
        "0" => {
          "id" => "1",
          "position" => "0.5"
        },
        "1" => {
          "id" => "2",
          "position" => "0.8"
        }
      }
      fpu = FocusPositionsUpdate.create_for_learner_with_focus_positions_attributes!(learner, attributes)
      expect(fpu.data).to eq({ 1 => 0.5, 2 => 0.8 })
    end
  end
end
