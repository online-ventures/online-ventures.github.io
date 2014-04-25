$(document).ready ->
  $(document).foundation()
  $('.exit-off-canvas, .right-off-canvas-toggle').on 'click.fndtn.offcanvas', ->
    $('#sidebar').click()
  popup = new AjaxifyModal('contact-popup')
  popup.form.submit (e) ->
    $('#contact-popup form').trigger('ajax:send')
    e.preventDefault()
    false
