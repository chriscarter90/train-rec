//= require helpers/setup
describe("ActivityItemView", function () {
  var ActivityItemView = require('views/activity_item_view'),
      view;

  beforeEach(function () {
    view = new ActivityItemView();
  });

  it("is a list item", function () {
    expect(view.$el).toBe('li');
  });
});
