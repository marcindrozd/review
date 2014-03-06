Review.CommitStateLabelComponent = Ember.Component.extend
  tagName: 'span'
  classNames: ['label']
  classNameBindings: ['labelClass']

  reviewState: 'unknown'

  labelClass:(()->
    switch @get('reviewState')
      when 'accepted' then 'label-success'
      when 'pending' then 'label-info'
      when 'passed' then 'label-warning'
      when 'rejected', 'auto_rejected' then 'label-danger'
      else 'label-default'
  ).property('reviewState')
