var app = require('app'),
    ActivityItemView = require('views/activity_item_view');

module.exports = app.CollectionView.extend({
  tagName: 'ol',
  itemView: ActivityItemView,
  events: {
    'click .remove': 'handleDelete'
  },
  handleDelete: function (e) {
    // TODO i18n; when we're doing this over XHR we'll make use of marionette and attach this per item
    if (!confirm('Are you sure?')) e.preventDefault();
  }
});
