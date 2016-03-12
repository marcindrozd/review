import Ember from 'ember';
var Component;

Component = Ember.Component.extend({
  classNames: "commit-tag-list",
  orderedTags: Ember.computed('tags.[]', function() {
    var ref;
    return Ember.A((ref = this.get('tags')) != null ? ref.sort() : void 0);
  }),
  actions: {
    removeTag: function(name) {
      return this.sendAction("action", name);
    }
  }
});

export default Component;
