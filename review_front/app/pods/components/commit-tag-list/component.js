import Ember from 'ember';

export default Ember.Component.extend({
  classNames: "commit-tag-list",
  orderedTags: Ember.computed('tags.[]', function() {
    return this.get("tags").sort();
  }),

  actions: {
    removeTag(name) {
      return this.sendAction("action", name);
    }
  }
});
