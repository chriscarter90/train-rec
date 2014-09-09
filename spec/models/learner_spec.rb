require 'spec_helper'

describe Learner do
  describe 'validations' do
    it { should have_many :reports }

    it 'has a valid factory' do
      expect(Learner.make).to be_valid
    end

    it 'requires a name' do
      expect(Learner.make(:name => "")).not_to be_valid
    end

    it 'requires an email' do
      expect(Learner.make(:email => "")).not_to be_valid
    end

    it 'requires the email to be unique' do
      Learner.make!(:email => "bob@example.com")
      expect(Learner.make(:email => "bob@example.com")).not_to be_valid
    end

    it 'requires a password' do
      expect(Learner.make(:password => "")).not_to be_valid
    end
  end

  describe 'anonymous' do
    it 'finds the anonymous learner if it exists' do
      Learner.make!(:email => "real_first@example.com")
      anon = Learner.make!(:email => "anonymous@example.com")
      Learner.make!(:email => "real_last@example.com")
      expect(Learner.anonymous).to eql(anon)
    end

    it 'creates and returns an anonymous learner if none exists' do
      anon = Learner.anonymous
      expect(anon.name).to eql("Anonymous")
      expect(anon.email).to eql("anonymous@example.com")
    end
  end

  describe '#avatar' do
    let(:learner) { Learner.make }

    context 'when the learner has not uploaded an avatar' do
      it 'should not have an avatar url' do
        expect(learner.avatar.url).to be_nil
      end
    end

    context 'when the learner has uploaded an avatar' do
      before do
        avatar = File.join(Rails.root, 'app', 'assets', 'images', 'default_avatar.png')
        learner.avatar = File.open(avatar)
        learner.save
      end

      it 'should have an avatar url' do
        expect(learner.avatar.url).to be_present
      end
    end
  end

  describe '#initialize_focus_positions!' do
    before do
      Focus.make!(name: "Empathy")
      Focus.make!(name: "Responsibility")
    end
    
    let(:learner) { Learner.make! }

    it 'initializes focus position for each existing focus' do
      expect{learner.initialize_focus_positions!}.to change{learner.focus_positions.count}.by(2)
      expect(learner.focus_positions.map(&:focus).map(&:name).sort).to eq ["Empathy", "Responsibility"]
    end

    it 'sets the value of a new focus position to the default' do
      learner.initialize_focus_positions!
      expect(learner.focus_positions.first.position).to eq FocusPosition::DEFAULT_POSITION
    end

    it 'does not add a focus position if the learner already has one for the focus' do
      learner.focus_positions.create(focus: Focus.first, position: 0.7)
      expect{learner.initialize_focus_positions!}.to change{learner.focus_positions.count}.by(1)
      expect(learner.focus_positions.map(&:focus).map(&:name).sort).to eq ["Empathy", "Responsibility"]
    end

    it 'maintains existing focus position' do
      focus = Focus.first
      learner.focus_positions.create(focus: focus, position: 0.7)
      learner.initialize_focus_positions!
      expect(learner.focus_positions.find_by_focus_id(focus.id).position).to eq 0.7
    end
  end
end
