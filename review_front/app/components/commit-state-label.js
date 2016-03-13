import Ember from 'ember';
var CommitStateLabel;

CommitStateLabel = Ember.Component.extend({
  tagName: 'span',
  classNames: ['label'],
  classNameBindings: ['labelClass'],
  reviewState: 'unknown',
  labelClass: Ember.computed('reviewState', function() {
    switch (this.get('reviewState')) {
      case 'accepted':
        return 'label-success';
      case 'pending':
        return 'label-info';
      case 'passed':
        return 'label-warning';
      case 'rejected':
      case 'auto_rejected':
        return 'label-danger';
      default:
        return 'label-default';
    }
  })
});

export default CommitStateLabel;
