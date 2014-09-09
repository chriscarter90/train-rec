require 'spec_helper'

describe Achievement do
  describe 'validations' do
    it 'has a valid factory' do
      expect(Achievement.make).to be_valid
    end

    it 'requires a name' do
      expect(Achievement.make(:name => "")).to be_valid
    end
    
    it 'requires a learner' do
      expect(Achievement.make(:learner => nil)).not_to be_valid
    end

    it { should ensure_length_of(:name).is_at_most(255) }
    it { should validate_presence_of(:description) }

  end

  describe 'from tracker' do
    it "sets the learner id from it's associated tracker" do
      tracker = Tracker.make!
      achievement = Achievement.make!(tracker: tracker, learner: nil)
      expect(achievement.learner).to eq(tracker.learner)
    end
  end

  describe 'scopes' do
    describe 'default' do
      it 'orders by created_at date, most recent first' do
        a2 = Achievement.make!(created_at: 2.days.ago)
        a3 = Achievement.make!(created_at: 3.days.ago)
        a1 = Achievement.make!(created_at: 1.days.ago)
        expect(Achievement.all.map(&:id)).to eql([a1, a2, a3].map(&:id))
      end
    end
  end

  describe '#asset' do
    let(:achievement) { Achievement.make }

    context 'when the achievement has no asset' do
      it 'should not have an asset url' do
        expect(achievement.asset.url).to be_nil
      end
    end

    context 'when the achievement has uploaded an asset' do
      before do
        asset = File.join(Rails.root, 'app', 'assets', 'images', 'default_avatar.png')
        achievement.asset = File.open(asset)
        achievement.save
      end

      it 'should have an asset url' do
        expect(achievement.asset.url).to be_present
      end
    end
  end
end
