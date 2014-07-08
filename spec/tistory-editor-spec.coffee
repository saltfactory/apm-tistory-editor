{WorkspaceView} = require 'atom'
TistoryEditor = require '../lib/tistory-editor'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TistoryEditor", ->
  activationPromise = null

  beforeEach ->
    console.log 'beforeEach'
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('tistory-editor')

  describe "when the tistory-editor:build event is triggered", ->
    it "should be opened in an edito", ->
      # This is an activation event, triggering it will cause the package to be
      # activated.
      # atom.workspaceView.trigger 'tistory-editor:build'

      waitsForPromise ->
        #  activationPromise
        atom.workspace.open("./test.md")

      runs ->
        # expect(atom.workspaceView, 'test').toBe(true)
        # atom.workspaceView.trigger 'tistory-editor:build'
      #

  #
  # describe "when the tistory-editor:toggle event is triggered", ->
  #   it "attaches and then detaches the view", ->
  #     expect(atom.workspaceView.find('.tistory-editor')).not.toExist()
  #
  #     # This is an activation event, triggering it will cause the package to be
  #     # activated.
  #     atom.workspaceView.trigger 'tistory-editor:toggle'
  #
  #     waitsForPromise ->
  #       activationPromise
  #
  #     runs ->
  #       expect(atom.workspaceView.find('.tistory-editor')).toExist()
  #       atom.workspaceView.trigger 'tistory-editor:toggle'
  #       expect(atom.workspaceView.find('.tistory-editor')).not.toExist()
  #
  #
