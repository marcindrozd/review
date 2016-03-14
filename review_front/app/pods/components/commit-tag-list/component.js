import Ember from 'ember';

export default Ember.Component.extend({
  classNames: "commit-tag-list",
  orderedTags: Ember.computed('tags.[]', function() {
    const tags = this.get("tags");
    if (tags !== undefined) {
      return this.get("tags").sort();
    } else {
      return Ember.A();
    }
  }),

  actions: {
    removeTag(name) {
      return this.sendAction("action", name);
    }
  }
});
