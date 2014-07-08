# exec = require("child_process").exec
# fs = require 'fs-extra'
# mime = require 'mime'
# path = require 'path'
# $ = require 'cheerio'

htmlrender = require "#{atom.packages.getLoadedPackage('tistory-editor').path}/lib/html-render"

module.exports =
  configDefaults: {
    args: {
      dest: './dest'
    }
  }

  activate: (state) ->
    atom.workspaceView.command "tistory-editor:build", (event) =>
      @build()

  deactivate: ->
    # console.log('deactivate')
    # @tistoryEditor.destory()

  build: ->
    # console.log('build');
    filepath = atom.workspaceView.find('.tree-view .selected')?.view()?.getPath?()

    fs.stat filepath, (err, state) ->
      if state.isFile()
        if filepath and path.extname(filepath) == '.html'
          dest = atom.config.settings['tistory-editor'].args.dest
          htmlrender.init(filepath, dest)
          htmlrender.copyHtml()

          # @html = $.load(fs.readFileSync(filepath))
          #
          # @html('img').each (i, element) =>
          #   imagepath = $(element).attr('src')
          #   if (imagepath.indexOf('http://') == -1) and (imagepath.indexOf('https://') == -1)
          #     image = fs.readFileSync(imagepath)
          #     dataurl = "data:#{mime.lookup(imagepath)};base64,#{image.toString('base64')}"
          #     $(element).attr('src', dataurl)
          #
          # filename = path.join(dest, path.basename(filepath))
          # fs.writeFileSync(filename, @html.html())




# TistoryEditorView = require './tistory-editor-view'
#
# module.exports =
#   tistoryEditorView: null
#
#   activate: (state) ->
#     @tistoryEditorView = new TistoryEditorView(state.tistoryEditorViewState)
#
#   deactivate: ->
#     @tistoryEditorView.destroy()
#
#   serialize: ->
#     tistoryEditorViewState: @tistoryEditorView.serialize()
