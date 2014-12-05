class @Mercury.Snippet

  @all: []

  @displayOptionsFor: (name) ->
    Mercury.modal Mercury.config.snippets.optionsUrl.replace(':name', name), {
      title: 'Block Options'
      handler: 'insertSnippet'
      snippetName: name
    }
    Mercury.snippet = null


  @create: (name, options) ->
    identity = "block_#{new Date().getTime()}"
    instance = new Mercury.Snippet(name, identity, options)
    @all.push(instance)
    return instance


  @find: (identity) ->
    for snippet in @all
      return snippet if snippet.identity == identity
    return null


  @load: (snippets) ->
    for own identity, details of snippets
      instance = new Mercury.Snippet(details.name, identity, details.options)
      @all.push(instance)


  constructor: (@name, @identity, options = {}) ->
    @version = 0
    @data = ''
    @really_save = false
    @history = new Mercury.HistoryBuffer()
    @setOptions(options)


  getHTML: (context, callback = null) ->
    element = jQuery('<div class="mercury-snippet" contenteditable="false">', context)
    element.attr({'data-snippet': @identity})
    element.attr({'data-version': @version})
    element.html("[#{@identity}]")
    @loadPreview(element, callback)
    return element


  getText: (callback) ->
    return "[--#{@identity}--]"


  loadPreview: (element, callback = null) ->
    #    @options_to_save = @options
    save_data = jQuery.extend({}, @options)
    save_data['identity'] = @identity

    if @really_save
      base_url = Mercury.config.snippets.storeUrl
    else
      base_url = Mercury.config.snippets.previewUrl
    
    jQuery.ajax base_url.replace(':name', @name), {
      headers: Mercury.ajaxHeaders()
      type: Mercury.config.snippets.method
      data: save_data
      success: (data) =>
        @data = data
        element.html(data)
        callback() if callback
      error: =>
        Mercury.notify('Error loading the preview for the \"%s\" snippet.', @name)
    }


  displayOptions: ->
    Mercury.snippet = @
    # TODO: block_options  
    block_options_window(@name, @identity);

  setOptions: (@options) ->
    delete(@options['authenticity_token'])
    delete(@options['utf8'])
    @version += 1
    @history.push(@options)
    Mercury.log("Set Options: ", @options)

  reallySave: ->
    @really_save = true

  setVersion: (version = null) ->
    version = parseInt(version)
    if version && @history.stack[version - 1]
      @version = version - 1
      @options = @history.stack[@version]
      return true
    return false


  serialize: ->
#    Mercury.log("Serialising options: " , @options_to_save)
    return {
      name: @name
      options: @options
    }
