$(function () {

    $('.fileupload-content').append('<div id="loading"></div>');
$('.fileupload-content').show();
    var inputs = $('#new_picture :input[type=text]');
    
    clearFields(inputs);
    
    function clearFields (inputs) {
      $('.ui-state-error-text').remove();
      $.each(inputs, function(index, field){
        $(field).focus(function(){
          $(field).removeClass("ui-state-error");
          $(field).next().remove();
        });
      });
    };
  
    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
      url: '/galleries/get_file',
      method: "post",
      maxNumberOfFiles: 10,
      acceptFileTypes: /\.(jpg|jpeg|gif|png|JPG|JPEG|GIF|PNG)$/ ,
      dataType: 'script' ,
      formData: {
        
      }
    });
    
    // 
    // Load existing files:
    $.getJSON("/galleries/get_file", function (files) {
        var fu = $('#fileupload').data('fileupload');
        //fu._adjustMaxNumberOfFiles(-files.length);
        fu._renderDownload(files)
            .appendTo($('#fileupload .files'))
            .fadeIn(function () {
                // Fix for IE7 and lower:
                $(this).show();
            });
            
            // $(".best_in_place").best_in_place();
            // Shadowbox.init();
            $('#loading').hide();
    });

    // Open download dialogs via iframes,
    // to prevent aborting current uploads:
    $('#fileupload .files a:not([target^=_blank])').on('click', function (e) {
        e.preventDefault();
        $('<iframe style="display:none;"></iframe>')
            .prop('src', this.href)
            .appendTo('body');
    });
    
    
    $('#fileupload').bind('fileuploadsend', function (e, data) {
      
      var values = {};
      
      $.each($('#new_picture').serializeArray(), function(i, field) {
          values[field.name] = field.value;
      });

      var title = values["picture[title]"]
      var description = values["picture[description]"]
      
      $.each( values, function(k, v){
        if (v == 0) {
          $('input[name="' + k + '"]').addClass("ui-state-error");
          $('input[name="' + k + '"]').after("<span class=\"ui-state-error-text\"> can't be blank!</span>");
        }
       });

    });
    $('#fileupload').bind('fileuploaddone', function(e,data){  
    // $("#popup").show();
    $("#clicker").click();
                        setTimeout(function(){
                          $("#popup").show();
                                 $('#imglogo').Jcrop({
                                  // aspectRatio: 150/100,
                                  onSelect: $.showCoords
                                 }); 

                                },1000);
                         });
    $('#fileupload').bind('fileuploadprogressall', function (e,data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      //$('.progress-bar').find('div').css('width',  progress + '%').find('span').html(progress + '%');
      console.info(progress);
    });
     

});