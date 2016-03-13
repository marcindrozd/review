import Ember from 'ember';

export default Ember.Component.extend({
  idEditing: false,
  actions: {
    displayTagsForm() {
      return this.set('isEditing', true);
    },
    createTag() {
      var commit, tagNames;
      tagNames = this.get('tagNames');
      commit = this.get('commit');
      if (tagNames === void 0 || tagNames === '') {
        return;
      }
      commit.set('tag', this.createTagsArray(commit, tagNames)).save();
      this.set('isEditing', false);
      return this.set('tagNames', '');
    },
    dropEdits() {
      this.set("isEditing", false);
      return this.set('tagNames', '');
    },
    removeTag(name) {
      var commit, currentTags, index;
      commit = this.get('commit');
      currentTags = commit.get('tag');
      index = currentTags.indexOf(name);
      currentTags.splice(index, 1);
      commit.set('tag', currentTags).save();
      return this.rerender();
    }
  },
  createTagsArray(commit, tags) {
    var addedTags, currentTags;
    currentTags = commit.get('tag');
    addedTags = tags.split(',');
    return this.uniqueTags(currentTags.concat(addedTags));
  },
  uniqueTags(tags) {
    var i, unique;
    unique = [];
    i = 0;
    while (i < tags.length) {
      if (unique.indexOf(tags[i]) === -1) {
        unique.push(tags[i]);
      }
      i++;
    }
    return unique;
  }
});
