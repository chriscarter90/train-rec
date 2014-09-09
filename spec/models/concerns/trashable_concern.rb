shared_examples "trashable" do
  it "is not in the default scope when trashed" do
    trashable = subject.class.make!
    id = trashable.id
    trashable.trash
    expect(subject.class.find_by_id(id)).to be_nil
  end

  it "is still in the scope when trashed with the time at which it was trashed" do
    trashable = subject.class.make!
    id = trashable.id
    trashable.trash
    trashed_item = subject.class.trashed.find_by_id(id)
    expect(trashed_item).to eq(trashable)
    expect(Time.current - trashed_item.trashed_at).to be < 10.seconds
  end
end
