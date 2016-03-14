import Ember from 'ember';

export default Ember.Component.extend({
  placeholder: "Search…",
  search: Ember.computed.oneWay("query"),
  onSearchChange: Ember.observer("search", function() {
    return Ember.run.debounce(this, this.processSearchChange, 200);
  }),
  processSearchChange() {
    return this.sendAction("action", this.get("search"));
  }
});
