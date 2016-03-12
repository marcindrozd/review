import Ember from 'ember';
var Component;

Component = Ember.Component.extend({
  placeholder: "Search…",
  search: Ember.computed.oneWay("query"),
  onSearchChange: Ember.observer("search", function() {
    return Ember.run.debounce(this, this.processSearchChange, 200);
  }),
  processSearchChange: function() {
    return this.sendAction("action", this.get("search"));
  }
});

export default Component;
