//= require jquery
//= require lodash
//= require backbone/backbone
//= require backbone.marionette/lib/backbone.marionette.js
//= require handlebars.runtime
//= require_tree ./templates

Backbone.Marionette.Renderer.render = function(template, data){
  return HandlebarsTemplates[template](data);
};

module.exports = {
  bus: new Backbone.Wreqr.EventAggregator(),
  View: Backbone.Marionette.View,
  ItemView: Backbone.Marionette.ItemView,
  CollectionView: Backbone.Marionette.CollectionView,
  Model: Backbone.Model,
  Collection: Backbone.Collection,
  Router: Backbone.Router
};