{$$, BufferedProcess} = require 'atom'

module.exports =

  activate: ->
    atom.workspaceView.command 'update-packages:update', => @update()

  update: ->
    view = @createProgressView()
    atom.workspaceView.append(view)

    command = atom.packages.getApmPath()
    args = ['upgrade', '-c', 'false']

    exit = (code, signal) ->
      atom.workspaceView.one 'core:cancel', -> view.remove()
      view.empty().focus().on 'focusout', -> view.remove()

      success = (code == 0)
      if success
        view.append $$ ->
          @div class: 'text-success', 'Packages updated.'
      else
        view.append $$ ->
          @div class: 'text-error', 'Failed to update packages.'

    new BufferedProcess({command, args, exit})

  createProgressView: ->
    $$ ->
      @div tabindex: -1, class: 'overlay from-top', =>
        @span class: 'loading loading-spinner-small inline-block'
        @span "Updating packages\u2026"
