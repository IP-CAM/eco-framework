jQuery(window).scroll(function() {
    if (jQuery(this).scrollTop() > 1){
        jQuery('nav#menu').addClass("sticky");
    }
    else{
        jQuery('nav#menu').removeClass("sticky");
    }
});