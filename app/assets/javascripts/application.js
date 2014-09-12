//= require jquery
//= require lightbox-2.6.min
//= require jquery_ujs
//= require bootstrap
//= require fileinput
//= require flat-ui-pro
//= require_tree .

// $(".image-upload-fake").click( function (){
//   handleFakeImageUpload($(this));
// });

function handleFakeImageUpload(e) {
  // relies on the "real" input being the next DOM element:
  // console.log(e)
  // var filename = $(this).val()
  // console.log(filename);
  // e.next().trigger("click");
  // console.log($(this).prev());

  // e.next().change(function() {
  //   var filename = $(this).val()
  //   console.log("Filename: "+filename);
  //   if(filename.indexOf("No file") !== -1 || filename.length === 0) {
  //     e.html("Select a picture");
  //   } else {
  //     e.html(filename);
  //     e.css("background-image","none");
  //   }
  // });
}

// ML-94 show/hide new (compact/inline) achievement form

$("#new_achievement #achievement_description").focus( function() {
  achievementFormShow();
})
// if we are on the achievements/new page show the form
$(function(){
  if(window.location.href.indexOf('achievements/new') > 0){
      achievementFormShow();
  }
  if(window.location.pathname !== '/dashboard') {
    $("#achievement_name").show();
    // console.log("NOT Dashboard");
  }

  $("select").select2({dropdownCssClass: 'dropdown-inverse'});
})

function achievementFormHide() {
  $("#achievement_description").hide();
  $("#achievement_focus_id").hide()
  $(".activity-form-controls").hide();
}

function achievementFormShow() {
  $("#achievement_description").show();
  $("#achievement_focus_id").show()
  $(".activity-form-controls").show();
}

// focus-range .change watcher changes color of slider
// according to the value of the range
$(function() {
  $(".focus-range").change( function(){
    setFocusSliderColor($(this));
  });
}());

// initialize the of slider positions
$.each($(".focus-range"), function() {
  setFocusSliderColor($(this));
});

// set color of slider beofre button to indicate level
function setFocusSliderColor(e) {
  // $(this).next().val( Math.floor($(this).val()*100) ); //display value
  // Borrowed from: http://stackoverflow.com/a/18389801/1148249
  var val = (e.val() - e.attr('min')) / (e.attr('max') - e.attr('min'));
  e.css('background-image',
              '-webkit-gradient(linear, left top, right top, '
              + 'color-stop(' + val + ', #FBFBFB), '
              + 'color-stop(' + val + ', #42494C)'
              + ')'
  );
}
