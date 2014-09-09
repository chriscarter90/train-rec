require 'spec_helper'

describe Tracker do
  it_behaves_like "trashable"

  describe 'validations' do
    subject { Tracker.make }
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:learner) }
    it { should ensure_length_of(:name).is_at_most(255) }

    it 'has a valid factory' do
      expect(Tracker.make).to be_valid
    end

    it 'Does NOT require a description' do
      expect(Tracker.make(:description=> "")).to be_valid
    end
  end

  describe 'scopes' do
    describe 'default' do
      it 'orders by created_at date, most recent first' do
        a2 = Tracker.make!(created_at: 2.days.ago)
        a3 = Tracker.make!(created_at: 3.days.ago)
        a1 = Tracker.make!(created_at: 1.days.ago)
        expect(Tracker.all.map(&:id)).to eql([a1, a2, a3].map(&:id))
      end
    end

    describe 'difficulty' do
      let!(:easy) { Tracker.make!(difficulty: 'easy') }
      let!(:medium) { Tracker.make!(difficulty: 'medium') }
      let!(:hard) { Tracker.make!(difficulty: 'hard') }

      describe '.easy' do
        it 'returns trackers with an easy difficulty' do
          expect(Tracker.easy).to match_array([easy])
        end
      end

      describe '.medium' do
        it 'returns trackers with a medium difficulty' do
          expect(Tracker.medium).to match_array([medium])
        end
      end

      describe '.hard' do
        it 'returns trackers with a hard difficulty' do
          expect(Tracker.hard).to match_array([hard])
        end
      end

    end
  end
end
