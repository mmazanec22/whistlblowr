// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function(){
  // $(".mobile-form-textarea").on('keyup', function( event ){
  //   // $this = $(this)
  //   // var scrollSize = $this.scrollTop()
  //   // var rows = $this.attr("rows")
  //   // console.log(scrollSize)
  //   // if (scrollSize>0) {
  //   //   $this.attr("rows", parseInt(rows)+1)
  //   //
  //   textareaAutoResize($(this));
  // }
  // )


  $(".mobile-form-textarea").on('keyup', function(event){

    textareaAutoResize($(this))

  })

})



      var hiddenDiv = $('.hiddendiv').first();

      if (!hiddenDiv.length) {
        hiddenDiv = $('<div class="hiddendiv common"></div>');
        $('body').append(hiddenDiv);
      }

function textareaAutoResize($textarea) {


      // Set font properties of hiddenDiv

      var fontFamily = $textarea.css('font-family');
      var fontSize = $textarea.css('font-size');
      var lineHeight = $textarea.css('line-height');

      if (fontSize) { hiddenDiv.css('font-size', fontSize); }
      if (fontFamily) { hiddenDiv.css('font-family', fontFamily); }
      if (lineHeight) { hiddenDiv.css('line-height', lineHeight); }

      if ($textarea.attr('wrap') === "off") {
        hiddenDiv.css('overflow-wrap', "normal")
        .css('white-space', "pre");
      }

      console.log(fontFamily)

      hiddenDiv.text($textarea.val() + '\n');

      var content = hiddenDiv.html().replace(/\n/g, '<br>');
      hiddenDiv.html(content);

      console.log("hdiv content= "+hiddenDiv.html())


      // When textarea is hidden, width goes crazy.
      // Approximate with half of window size

      if ($textarea.is(':visible')) {
        hiddenDiv.css('width', $textarea.width());
      }
      else {
        hiddenDiv.css('width', $(window).width()/2);
      }

      console.log("hd height="+hiddenDiv.height())

      $textarea.css('height', hiddenDiv.height());
    }
