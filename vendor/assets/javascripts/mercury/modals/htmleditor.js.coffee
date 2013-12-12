@Mercury.modalHandlers.htmlEditor = ->
  # fill the text area with the content
  content = Mercury.region.content(null, true, false)
  parent.frames[0].will_be_content = content

  # replace the contents on form submit
  @element.find('form').on 'submit', (event) =>
    event.preventDefault()
    value = parent.frames[0].html_editor.getValue()
    Mercury.trigger('action', {action: 'replaceHTML', value: value})
    @hide()
