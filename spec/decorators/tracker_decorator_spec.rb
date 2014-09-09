require 'spec_helper'

describe TrackerDecorator do
  subject(:tracker) { Tracker.make!.decorate }

  context "without a focus" do
    it "uses the 'undefined' name for focus" do
      expect(tracker.focus_name).to eq Focus::UNDEFINED_NAME
    end
  end
  
  context "with a focus" do
    let(:focus) { Focus.make!(name: "Agility") }
    
    it "uses focus' name" do
      tracker.update_attributes(focus_id: focus.id)
      expect(tracker.focus_name).to eq 'Agility'
    end
  end

  context "without a subject" do
    it "uses the 'undefined' name for subject" do
      expect(tracker.subject_name).to eq Subject::UNDEFINED_NAME
    end

    it "returns something blank as the subject_element" do
      expect(tracker.subject_element).to be_blank
    end
  end
  
  context "with a subject" do
    let(:subject) { Subject.make!(name: "Music") }
    
    it "uses subject' name" do
      tracker.update_attributes(subject_id: subject.id)
      expect(tracker.subject_name).to eq 'Music'
    end

    describe "subject_element" do
      it "has the subject in a span" do
        tracker.update_attributes(subject_id: subject.id)
        expect(tracker.subject_element).to eq "<span class='subject'>Music</span>"
      end

      it "escapes html entities in the name" do
        subj2 = Subject.make!(name: "&")
        tracker.update_attributes(subject_id: subj2.id)
        expect(tracker.subject_element).to include("&amp;")
      end
    end
  end

  describe '#difficulty' do
    context 'with a difficulty' do
      before do
        tracker.difficulty = 'hard'
      end

      its(:difficulty) { should eq 'hard' }
    end

    context 'without a difficulty' do
      its(:difficulty) { should eq 'medium' }
    end
  end
end
