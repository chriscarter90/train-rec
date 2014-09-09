require 'spec_helper'

describe Subject do

  describe 'validations' do
    it 'has a valid factory' do
      expect(Subject.make).to be_valid
    end

    it 'can create multiple default objects' do
      Subject.make!
      expect(Subject.make).to be_valid
    end
    
    it 'requires a name' do
      expect(Subject.make(:name => "")).not_to be_valid
    end

    it 'requires the name to be unique' do
      Subject.make!(:name => "Ape")
      expect(Subject.make(:name => "Ape")).not_to be_valid
    end
  end

  describe 'scopes' do
    describe 'default' do
      it 'orders by name' do
        f3 = Subject.make!(name: "History")
        f2 = Subject.make!(name: "Graphics")
        f1 = Subject.make!(name: "Geography")
        expect(Subject.all.map(&:id)).to eql([f1, f2, f3].map(&:id))
      end
    end
  end

  describe "select_options" do
    it "has 'No subject' as the option that is nil and first" do
      expect(Subject.select_options.first).to eq ["No subject", nil]
    end

    it "has options for the available subjects, ordered by subject name" do
      f2 = Subject.make!(name: "Graphics")
      f1 = Subject.make!(name: "Geography")
      f3 = Subject.make!(name: "History")

      expected_options = [ [f1.name, f1.id],
                           [f2.name, f2.id],
                           [f3.name, f3.id]
                         ]
      
      expect(Subject.select_options[1..-1]).to eq expected_options
    end
  end
end
