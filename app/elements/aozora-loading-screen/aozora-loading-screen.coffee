Polymer
  is: 'aozora-loading-screen'
  behaviors: [
    Aozora.behaviors.base,
    Polymer.NeonAnimationRunnerBehavior
  ]
  properties:
    animationConfig:
      value: ->
        show: [
          {
            name: 'fade-in-animation'
            node: @$.aozoraLogo
            timing:
              duration: 500
          },{
            name: 'fade-in-animation'
            node: @$.spinner
            timing:
              delay: 300
          }
        ]
        exit:
          name: 'fade-out-animation'
          node: @
          timing:
            duration: 400

  listeners:
    'neon-animation-finish': '_onAnimationFinish'

  ready: () ->
    @elementInit()

    # monkey patch since cannot @apply custom classes from iron-flex-layout
    # TODO remove later if iron-flex-layout works fine
    @toggleClass 'vertical', true
    @toggleClass 'layout', true
    @toggleClass 'flex', true
    @toggleClass 'fit', true
    @toggleClass 'center', true
    @toggleClass 'around-justified', true

    @_waitedEnoughTimeBeforeFadeOut = false
    @_triedToFadeOut = false
    @async =>
      if @_triedToFadeOut
        @fadeOut()
        return
      else
        @_waitedEnoughTimeBeforeFadeOut = true
    , 1000

  attached: ->
    @playAnimation 'show'

  tryFadeOut: ->
    if @_waitedEnoughTimeBeforeFadeOut
      @fadeOut()
      return
    else
      @_triedToFadeOut = true

  fadeOut: ->
    @_animationStatus = 'fading_out'
    @playAnimation 'exit'

  _onAnimationFinish: (e) ->
    return unless @_animationStatus is 'fading_out'
    Polymer.dom(@app.root).removeChild @