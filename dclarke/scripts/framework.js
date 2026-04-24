// JavaScript Document

/* Contact Form */
$(function() {
  $('.error').hide();
  $('input.text-input').css({backgroundColor:"#FFFFFF"});
  $('input.text-input').focus(function(){
    $(this).css({backgroundColor:"#FFDDAA"});
  });
  $('input.text-input').blur(function(){
    $(this).css({backgroundColor:"#FFFFFF"});
  });

  $(".button").click(function() {
		// validate and process form
		// first hide any error messages
    $('.error').hide();
		
	  var name = $("input#name").val();
		if (name == "") {
      $("label#name_error").show();
      $("input#name").focus();
      return false;
    }
		var email = $("input#email").val();
		if (email == "") {
      $("label#email_error").show();
      $("input#email").focus();
      return false;
    }
		var phone = $("input#phone").val();
		if (phone == "") {
      $("label#phone_error").show();
      $("input#phone").focus();
      return false;
    }
	
		var subject = $("select#subject").val();

		var comments = $("textarea#comments").val();
		if (comments == "") {
      $("label#comments_error").show();
      $("input#comments").focus();
      return false;
    }
		
		var dataString = 'name='+ name + '&email=' + email + '&phone=' + phone + '&subject=' + subject + '&comments=' + comments;
		/*alert (dataString);return false;*/
		
$.ajax({
      type: "POST",
      url: "bin/process.php",
      data: dataString,
      success: function() {
        $('#contact_form_list').html("<div id='message'></div>"); 
        $('#message').html("<h2 style='text-align:center;'>Message Submitted!</h2>")
        .append("<p style='text-align:center;'>Thanks - you are now connected with Dane-art.</p>")
        .hide()
        .fadeIn(1500, function() { $('#message');
        });
      }
     });
    return false;
	});
});
runOnLoad(function(){
  $("input#name").select().focus();
});
