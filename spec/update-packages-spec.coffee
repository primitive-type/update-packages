{WorkspaceView} = require 'atom'
UpdatePackages = require '../lib/update-packages'

describe "Update Packages", ->
  mainModule = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView

    waitsForPromise ->
      atom.packages.activatePackage('update-packages').then (pack) ->
        mainModule = pack.mainModule

  it "updates packages", ->
    spyOn(mainModule, 'update')
    atom.workspaceView.trigger "update-packages:update"
    expect(mainModule.update).toHaveBeenCalled()
