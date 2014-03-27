$(document).ready(function() {
  $(document).foundation();
  $('.exit-off-canvas, .right-off-canvas-toggle').on('click.fndtn.offcanvas', function() {
    $('#sidebar').click();
  });
});
