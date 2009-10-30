// Tells jQuery before it sends to change the header type to Accept javascript format. 
// Rails will read this and send back the javascript request. 
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
$.fn.submitSearch = function() {
  $(this).change(function() {
    $(this).parents("form").submit();
    // $(".loading_container").show();
  });
}
// Submits a form using an ajax call
// ex. $('#post-form').submitWithAjax();
$.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  })
};