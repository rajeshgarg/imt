//= require ext/jquery.Jcrop
//= require ext/jquery-ui
 
  
(jQuery)(function($){

  console.log("asdasd");
  var  cord = {x:0 , y:0, w:0, h:0},
  rotation = 0,
  flip_flop ="none";
  $.showCoords = function showCoords(c)  
  {
    cord = c,
    flip_flop = "none";
    rotation = 0;
    $.ajax({
      url: "/upload_images/preview", //sumbits it to the given url of the form
      data: {x: c.x, y: c.y, h: c.h, w: c.w,r: 0}  
      ,success: function(data){
        console.log(data);
        $('#croped').html(data);
      }
    });
  };
  
  $(".saveit").click(function(){
    c = cord
    $.ajax({
      url: "/upload_images/save_it",
      data: {x: c.x, y: c.y, h: c.h, w: c.w,r: rotation,f:flip_flop},
    })
  });

  var jcrop_api,
    boundx,
    boundy,
    $preview = $('#preview-pane'),
    $pcnt = $('#preview-pane .preview-container'),
    $pimg = $('#preview-pane .preview-container img'),
    xsize = $pcnt.width(),
    ysize = $pcnt.height();
    $(".resizeit").click(function(){
      $(".xyz").resizable();
    });

  $('.rotate').click(function(){
    var c = cord;
    $.ajax({
      url: "/upload_images/rotate",
      data: {x: c.x, y: c.y, h: c.h, w: c.w,r: rotation},
      success: function(data){
        $('#croped').html(data);
        rotation =(rotation+ 90);
      }
    })
  });
  
  $('.rotateanti').click(function(){
    var c = cord
    $.ajax({
      url: "/upload_images/rotate",
      data: {x: c.x, y: c.y, h: c.h, w: c.w,r: rotation},
      success: function(data){
        $('#croped').html(data);
        rotation =(rotation - 90);
      }
    })
  });

  $('.flipit').click(function(){
    c = cord;
    flip_flop = "flip";
    $.ajax({
      url: "/upload_images/flip",
      data: {x: c.x, y: c.y, h: c.h, w: c.w,r: rotation, flip: true},
      success: function(data){
        $('#croped').html(data);
      }
    })
  });

  $('.flopit').click(function(){
    c = cord;
    flip_flop = "flop";
    $.ajax({
      url: "/upload_images/flop",
      data: {x: c.x, y: c.y, h: c.h, w: c.w,r: rotation ,flop: true},
      success: function(data){
        $('#croped').html(data);
      }
    })
  });

  function updatePreview(c){
    if (parseInt(c.w) > 0){
      var rx = xsize / c.w;
      var ry = ysize / c.h;
      $pimg.css({
        width: Math.round(rx * boundx) + 'px',
        height: Math.round(ry * boundy) + 'px',
        marginLeft: '-' + Math.round(rx * c.x) + 'px',
        marginTop: '-' + Math.round(ry * c.y) + 'px'
      });
    }
  };
 
});
