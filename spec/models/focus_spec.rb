require 'spec_helper'

describe Focus do

  describe 'validations' do
    it 'has a valid factory' do
      expect(Focus.make).to be_valid
    end


    it 'can create multiple default objects' do
      Focus.make!
      expect(Focus.make).to be_valid
    end
    
    it 'requires a name' do
      expect(Focus.make(:name => "")).not_to be_valid
    end

    it 'requires the name to be unique' do
      Focus.make!(:name => "Ape")
      expect(Focus.make(:name => "Ape")).not_to be_valid
    end
  end

  describe 'scopes' do
    describe 'default' do
      it 'orders by name' do
        f2 = Focus.make!(name: "Confidence")
        f1 = Focus.make!(name: "Communication")
        f3 = Focus.make!(name: "Problem Solving")
        expect(Focus.all.map(&:id)).to eql([f1, f2, f3].map(&:id))
      end
    end
  end
  
  describe "select_options" do
    it "has 'General' as the option that is nil and first" do
      expect(Focus.select_options.first).to eq ["General", nil]
    end

    it "has options for the available foci, ordered by focus name" do
      f2 = Focus.make!(name: "Confidence")
      f1 = Focus.make!(name: "Communication")
      f3 = Focus.make!(name: "Problem Solving")

      expected_options = [ [f1.name, f1.id],
                           [f2.name, f2.id],
                           [f3.name, f3.id]
                         ]
      
      expect(Focus.select_options[1..-1]).to eq expected_options
    end
  end
end
