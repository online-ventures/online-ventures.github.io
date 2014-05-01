$(document).ready ->
  $(document).foundation()
  $('.exit-off-canvas, .right-off-canvas-toggle').on 'click.fndtn.offcanvas', ->
    $('#sidebar').click()
  popup = new AjaxifyModal('contact-popup')
  popup.form.submit (e) ->
    form = $('#contact-popup form')
    form.trigger('ajax:send')
    data = {
      name: $('#name').val()
      email: $('#email').val()
      message: $('#message').val()
    }
    $.post('http://app.wov.io/contact', data, ->
      form.trigger('ajax:success')
    )
    e.preventDefault()
    false
