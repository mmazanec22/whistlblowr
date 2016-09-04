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

//ajaxify the statuses on the comments index page AKA inspector interface
$(document).ready(function(){

  $(".status-button").on("click", function(event){
    event.preventDefault();

    var $clickedButton = $(this)
    console.log($clickedButton)
    var clickedButtonTrClass = "." + $clickedButton.closest("tr").attr("class").split(" ")[1]

    var route = $(this).attr("action");
    var verb = $(this).attr("method");
    var formData = $(this).serialize();
    console.log($(this))
    console.log(verb)
    console.log(route)

    var request = $.ajax({
      url: route,
      method: verb,
      data: formData
    })

    request.done(function(response){
      $(clickedButtonTrClass).find(".current-status").removeClass("disabled")
      console.log($(clickedButtonTrClass).find(".current-status"))
      $(clickedButtonTrClass).find(".current-status").removeClass("current-status")

      $clickedButton.addClass("current-status")
      $clickedButton.addClass("disabled")
    })
  })

  $('select').material_select();
  $(".status-form").change(function(){
    var filterBy = $(".status-form :selected").val()
    $(".table-row").hide()
    $("tr."+filterBy).show()
    if(filterBy=="All"){
      $("tr").show()
    }
  })

  // $(".allegation-form").change(function(){
  //   var filterBy = $(".allegation-form :selected").val().split(" ").join("-")
  //   $(".table-row").hide()
  //   $("tr."+filterBy).show()
  //   if(filterBy=="All"){
  //     $("tr").show()
  //   }
  // })
})
