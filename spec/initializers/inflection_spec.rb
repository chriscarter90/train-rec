require 'spec_helper'

describe "inflections" do
  it "pluralizes focus as foci" do
    expect("focus".pluralize).to eq "foci"
    expect("foci".singularize).to eq "focus"
  end
end
