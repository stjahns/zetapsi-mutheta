// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// TODO less hacky
function adjustThumbWidths() {
  var containerWidth = $('#slider-thumbs').width();
  var thumbCount = Math.ceil(containerWidth / 150);
  $('.album_nav_thumb').width(containerWidth / thumbCount - 4);
}

$(document).ready(function() {

  // Slide to image on thumbnail clicked
  $("[id^='carousel-selector-']").click(function(){
    var id_selector = $(this).attr("id");
    var id = id_selector.substr(id_selector.length - 1);
    id = parseInt(id);
    $('#carousel-example-generic').carousel(id);
    $('[id^=carousel-selector-]').removeClass('selected');
    $(this).addClass('selected');
  });

  // Update 'selected' thumb on carousel slid
  $('#carousel-example-generic').on('slid.bs.carousel', function(e) {
    var id = $('.item.active').data('slide-number');
    id = parseInt(id);
    $("[id^='carousel-selector-']").removeClass('selected');
    $("[id^='carousel-selector-" + id +"']").addClass('selected');
  });

  // Adjust thumbnail sizes to fit container now, and when window resized
  adjustThumbWidths();
  $(window).resize(adjustThumbWidths);
});
