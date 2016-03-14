import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'span',
  classNames: ['label', 'commit-tag'],
  attributeBindings: ['style'],
  style: Ember.computed("name", function() {
    const style = "background-color: " + (this.get("color")) + ";";
    return new Ember.Handlebars.SafeString(style);
  }),
  toHash(string) {
    var hash, i, idx, ref;
    hash = 0;
    for (idx = i = 0, ref = string.length - 1; 0 <= ref ? i <= ref : i >= ref; idx = 0 <= ref ? ++i : --i) {
      hash = string.charCodeAt(idx) + ((hash << 5) - hash);
    }
    return Math.abs(hash);
  },
  toColor(hash) {
    var hex;
    hex = hash.toString(16);
    hex += '000000';
    return "#" + (hex.substring(0, 6));
  },
  color: Ember.computed("name", function() {
    return this.toColor(this.toHash(this.get("name")));
  }),
  actions: {
    removeTag() {
      return this.sendAction("action", this.get("name"));
    }
  }
});
