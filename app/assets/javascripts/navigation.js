$(function () {
  // client side highlight navigation menu item by url
  var navItems = $("#nav li a");
  // itterate over nav items and apply active class if applicable
  $.each(navItems, function( index, value ) {
    if ( window.location.pathname.indexOf($(this).attr('href')) !== -1 ) {
      $(this).addClass('nav-active');  

      // because reports are sub-path of learner (learner/reports and learner/reports/new)
      // the "My Profile" nav item will be avctivated so we need to deactivate it ... #ugly :-(
      if(window.location.pathname.indexOf('learner/reports') !== -1 ) {
        $(".my-profile").removeClass('nav-active');  
      }
    }
  });
})