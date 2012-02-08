function setPositions(){
    var winwidth = $( window ).width()

    if( winwidth >= 750 ){
        $('.content-secondary').css({'float':'left','width':'35%'});
        $('.content-primary').css({'margin-left':'36%'});
    }
    else{
        $('.content-secondary').css({'float':'none','width':'100%'});
        $('.content-primary').css({'margin-left':'0px'});
    }
}


$(document).ready(function(){

  // http://www.photoswipe.com/
  /*
	var myPhotoSwipe = $(".image").photoSwipe({ 
	  imageScaleMethod: "fitNoUpscale", 
	  loop: false 
	});
	*/

  // setDefaultTransition();
  $( window ).bind( "throttledresize", setPositions );

});
