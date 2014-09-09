$("select#focus_id").on("change", function() {
  $(this).parent('form').submit();
})

$('form.edit_achievement').on('ajax:complete', function(event, xhr, settings) {
  var formId = $(this).attr('id')
  console.log(formId +" updated")
  var name = $('#'+formId +' .name.input').val();
  $('#'+formId +' .name.show').text(name);
    var desc = $('#'+formId +' .description.input').val();
  $('#'+formId +' .description.show').text(desc);
  highlightHashtags()
});

$('a.remove').on('ajax:complete', function(event, xhr, settings) {
  $(this).parents('li').slideUp();
});

// enable the form fields for editing
function dispalyEditFormFields(formId) {
  $('#'+formId +' .input').show();
  $('#'+formId +' .show').hide();
  $('#'+formId +' .update').show(); // show update button 
  $('#'+formId +' .remove').show(); // show remove button 
  $('#'+formId +' .edit').hide();   // hide edit button
}

function hideEditFormFields(formId) {
  $('#'+formId +' .input').hide(); 
  $('#'+formId +' .show').show();
  $('#'+formId +' .update').hide(); // hide update button 
  $('#'+formId +' .remove').hide(); // hide remove button 
  $('#'+formId +' .edit').show();   // show edit button
}

// display the "update" button
$(".edit").click(function(e) {
  var formId = $(this).parent().parent().attr('id');   // get the form id
  dispalyEditFormFields(formId);
});

// display the "edit" button again
$(".update").click(function(e) {
  var formId = $(this).parent().parent().attr('id');   // get the form id
  hideEditFormFields(formId);
});


/* Hashtag Highlighter */
  
$(function(){
  highlightHashtags()

})

function highlightHashtags() {
  var elems = document.getElementsByClassName('show'),
  match, m, pattern = /\s*(#\w*)/gi, text, t;

  for(var i=0; i < elems.length; i++){
    var matches = [];
    text = elems[i].textContent; // get the original text

    if(text.indexOf("#") !== -1) {   

      // in many cases there will be more than one hashtagged word in a block of text 
      while ( (match = pattern.exec(text)) ) {
        matches.push(match[0]);
      }

      // loop throught all the matches identified above and replace them with a bold colored text
      for(var j=0; j < matches.length; j++) {
        m = matches[j];
        t = "<b class='hashtag'>"+m+"</b>";
        replace = new RegExp("\\s*("+m+")", 'gi');
        console.log(replace)
        text = text.replace(replace, t);
      }
      elems[i].innerHTML = text;
    }
  }
}