var ActivityCollectionView = require('views/activity_collection_view');

module.exports = function () {
  // Removes the 300ms touch delay
  require('shims/fastclick')();

  new ActivityCollectionView({ el: '.tracker-list' });
};
