// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  $('#alert').ajaxError(function(e,xhr,options,error) {
    var msg = 'ajax error: ' + error;
    $(this).text(msg);
    alert(msg);
  });

  $('form#completed')
    .bind('ajax:success', function(e, data, status, xhr) {
      $(e.target).fadeOut(1000);
    });
});
