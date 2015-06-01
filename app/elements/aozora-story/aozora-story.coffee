Polymer
  is: 'aozora-story'
  behaviors: [ Aozora.behaviors.base ]
  properties:
    node:
      type: Object
      observer: '_nodeChanged'

  ready: ->
    @elementInit()

  _nodeChanged: (newNode, oldNode) ->
    @node.typeIsLine = @node.type is 'line'
    @node.typeIsNarrate = @node.type is 'narrate'
    @node.typeIsOptions = @node.type is 'options'

    @_render @node

  start: (node) ->
    @node = node

  _render: (node) ->
    # background
    if node.background?
      @app.background.background = node.background

    # conversation-box
    @app.conversationBox.node = node

  jumpToNode: (node) ->
    @node = node

  jumpToNextNode: ->
    return unless @node?

    # TODO IMPORTANT very bad performance, integrate IndexedDB
    getNodeById = (id) =>
      @app.resources.script.filter((node) -> node.id is id)[0]

    @node = getNodeById @node.next
