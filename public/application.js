$(document).ready(function(){

  var $actionLink = $('.js-clickable');
  var $target = $('.js-target');

  $actionLink.on('click', function(){
    // $target.toggle();
      $target.toggleClass("rot");
  });

});
