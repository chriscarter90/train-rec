require 'spec_helper'

describe FocusPosition do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FocusPosition.make).to be_valid
    end

    it 'requires a learner' do
      expect(FocusPosition.make(:learner => nil)).not_to be_valid
    end

    it 'requires a focus' do
      expect(FocusPosition.make(:focus => nil)).not_to be_valid
    end

    it 'can not be negative' do
      expect(FocusPosition.make(position: -0.1)).not_to be_valid
    end

    it 'can not be larger than 1' do
      expect(FocusPosition.make(position: 1.1)).not_to be_valid
    end
    
    it 'can be 0' do
      expect(FocusPosition.make(position: 0.0)).to be_valid
    end

    it 'can be 1' do
      expect(FocusPosition.make(position: 1.0)).to be_valid
    end
    
    it 'can be a float' do
      expect(FocusPosition.make(position: 0.5)).to be_valid
    end
  end
end
