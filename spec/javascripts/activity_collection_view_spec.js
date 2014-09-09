//= require helpers/setup
describe("ActivityCollectionView", function () {
  var ActivityCollectionView = require('views/activity_collection_view'),
      Collection = require('app').Collection,
      collection = new Collection([{ name: 'Read a book' }]),
      view;

  beforeEach(function () {
    view = new ActivityCollectionView({ collection: collection }).render();
  });

  it("renders activity", function () {
    expect(view.$el.find('li')).toHaveText('Read a book');
  });

  describe("when the remove button is clicked", function () {
    beforeEach(function () {
      view.$el.html('<li><button type="button" class="remove"></button></li>');
    });

    it("asks for confirmation", function () {
      spyOn(window, 'confirm');
      view.$el.find('.remove').click();

      expect(window.confirm).toHaveBeenCalledWith('Are you sure?');
    });

    describe("and it is confirmed", function () {
      it("it is not not prevented", function () {
        var clickSpy = spyOnEvent(view.$el.find('.remove'), 'click');
        spyOn(window, 'confirm').andReturn(true);
        view.$el.find('.remove').click();

        expect(clickSpy).not.toHaveBeenPrevented();
      });
    });

    describe("and it is not confirmed", function () {
      it("it is prevented", function () {
        var clickSpy = spyOnEvent(view.$el.find('.remove'), 'click');
        spyOn(window, 'confirm').andReturn(false);
        view.$el.find('.remove').click();

        expect(clickSpy).toHaveBeenPrevented();
      });
    });
  }); // end remove button clicked

  // describe("when creating a new achievement", function () {
  //   describe("and it is not confirmed", function () {
  //     it("it is prevented", function () {
        
  //     });
  //   });
  // });
  // >> put these tests in: spec/features/achievements_feature_spec.rb

});
