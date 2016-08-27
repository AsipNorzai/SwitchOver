$(".main-nav a").on("click", function(){
   $(".main-nav a").find(".active").removeClass("active");
   $(this).parent().addClass("active");
});
