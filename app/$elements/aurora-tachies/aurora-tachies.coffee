Polymer
  is: 'aurora-tachies'
  behaviors: [ Aurora.behaviors.base ]
  properties:
    tachies:
      type: Array
      observer: '_tachiesChanged'

  ready: ->

  _tachiesChanged: (newTachies, oldTachies) ->
    # lots TODO
    # say the proper transition
    # say same character's different tachies should still be the same position
