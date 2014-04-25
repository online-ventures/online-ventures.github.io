# A nifty array detection function
this.typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

# Ajaxify a modal relying on certain foundation elements
class AjaxifyModal
  constructor: (modal) ->
    @modal = $("##{modal}")
    @form = @modal.find('form')
    @loading = @modal.find('.loading')
    @success = @modal.find('.success')
    @errors = @modal.find('.alert')
    @form.on('ajax:send', =>
      @reset_form()
      @form.show().fadeOut duration: 200, done: =>
        @loading.fadeIn duration: 200
    ).on("ajax:success", (e, data, status, xhr) =>
      @reset_form()
      @loading.show().fadeOut duration: 200, done: =>
        @success.fadeIn duration:200
      @callback() if @callback
    ).on "ajax:error", (e, xhr, status, error) =>
      @reset_form()
      @loading.show().fadeOut duration: 200, done: =>
        @form.fadeIn duration:200
        @errors.html("<ul></ul>").fadeIn(duration:200)
        data = $.parseJSON xhr.responseText
        @receive_errors data

  reset_form: ->
    @form.stop(true).hide()
    @loading.stop(true).hide()
    @success.hide()
    @errors.hide()
    @modal.find("input,textarea,select").removeClass('error')

  show_loading: ->
    @reset_form()
    @loading.fadeIn duration: 200

  show_form: ->
    @reset_form()
    @form.fadeIn duration: 200, ->
      @form.find('input:first').focus()

  receive_errors: (data) ->
    for model, errors of data
      for field, text of errors
        if typeIsArray text
          text = text.join ' and '
        @errors.find("ul").append "<li>#{field.humanize()} #{text}</li>"
        @modal.find("##{model}_#{field}").addClass('error')

@AjaxifyModal = AjaxifyModal

class AjaxifyForm
  constructor: (form_container) ->
    @container = $("##{form_container}")
    @form = @container.find('form')
    @loading = @container.find('.loading')
    @success = @container.find('.success')
    @errors = @container.find('.alert')

  reset_form: ->
    @form.stop(true).hide()
    @loading.stop(true).hide()
    @loading.height @form.outerHeight()
    @success.hide()
    @errors.hide()
    @container.find("input,textarea,select").removeClass('error')

  show_loading: ->
    @reset_form()
    @loading.fadeIn duration: 200

  show_form: ->
    @reset_form()
    @form.fadeIn duration: 200

  receive_errors: (data) ->
    for model, errors of data
      for field, text of errors
        if typeIsArray text
          text = text.join ' and '
        @errors.find("ul").append "<li>#{field.humanize()} #{text}</li>"
        @container.find("##{model}_#{field}").addClass('error')

@AjaxifyForm = AjaxifyForm

