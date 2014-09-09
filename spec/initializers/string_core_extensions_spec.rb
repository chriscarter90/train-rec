require 'spec_helper'

describe String do
  describe "cssify" do
    it "uses the name in lower case" do
      expect("Communication".cssify).to eq "communication"
    end

    it "puts a dash for each space" do
      expect("a and b".cssify).to eq "a-and-b"
    end

    it "ignores surrounding spaces" do
      expect("  a   and b  ".cssify).to eq "a-and-b"
    end
  end
end
