$ = require 'cheerio'
fs = require 'fs-extra'
mime = require 'mime'
path = require 'path'

module.exports =
  init : (filepath, dest) ->
    @filepath = filepath
    @dest = dest

    if !fs.existsSync(@dest)
      fs.mkdirSync(@dest)

    @html = $.load(fs.readFileSync(@filepath), {
      normalizeWhitespace: false,
      xmlMode: false,
      decodeEntities: false
      })



  print: ->
    console.log "#{@html.html()}"

  loadHtml: (src)->
    return $.load(fs.readFileSync(src))

  rmdir: (src) ->
    if fs.existsSync(src)
      fs.readdirSync(src).forEach (file, index) =>
        filepath =  path.join(src, file)
        if fs.lstatSync(filepath).isDirectory()
          @rmdir(filepath)
        else
          fs.unlinkSync(filepath)
      fs.rmdirSync(src)

  # removeSpace:(str) ->
  #   return str.replace(/(\s)/g, "\\ ")

  copyHtml: ->
    outputDir = path.join(@dest, path.basename(@filepath).split('.')[0])
    # console.log outputDir

    @rmdir(outputDir)
    fs.mkdirSync(outputDir)

    @html('img').each (i, element) =>
      imagepath = $(element).attr('src')

      if (imagepath.indexOf('http://') == -1) and (imagepath.indexOf('https://') == -1)
        imagedest = path.basename(imagepath)
        @copyImageSync(imagepath, path.join(outputDir, imagedest))
        $(element).attr('src', imagedest)

    filename = path.join(outputDir, path.basename(@filepath))
    fs.writeFileSync(filename, @html.html())

    @build()

  copyImageSync: (src, dest) ->
    if(!fs.existsSync(dest))
      fs.copySync(src, dest)
    else
      console.log "#{dest} exists!"


  build: ->
    @html('img').each (i, element) =>
      imagepath = $(element).attr('src')
      if (imagepath.indexOf('http://') == -1) and (imagepath.indexOf('https://') == -1)
        imagepath = path.join(@dest, path.basename(@filepath).split('.')[0], $(element).attr('src'))
        dataurl = "data:#{mime.lookup(imagepath)};base64,#{fs.readFileSync(imagepath).toString('base64')}"
        $(element).attr('src', dataurl)

    outputDir = path.join(@dest, 'output')

    if !fs.existsSync(outputDir)
      fs.mkdirSync(outputDir)

    filename = path.join(outputDir, path.basename(@filepath))
    fs.writeFileSync(filename, @html.html())
