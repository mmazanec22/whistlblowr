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
//no longer require turbolinks
//= require_tree .

//ajaxify the statuses on the comments index page AKA inspector interface
$(document).ready(function(){

  $(".complaint-table").find(".table-row").hide()
  $(".complaint-table").find(".table-row.New").show()

  $("form.status-button").on("click", function(event){
    event.preventDefault();

    var $clickedButton = $(this).find(".btn-small")
    var clickedButtonTrComplaintIdClass = "." + $clickedButton.closest("tr").attr("class").split(" ")[1]
    var oldTrStatusClassArray = $clickedButton.closest("tr").attr("class").split(" ")
    var oldTrStatusClass = oldTrStatusClassArray[oldTrStatusClassArray.length-1]

    var route = $(this).attr("action");
    var verb = $(this).attr("method");
    var formData = $(this).serialize();

    var request = $.ajax({
      url: route,
      method: verb,
      data: formData,
      dataType: 'json'
    });

    request.done(function(response){
      $(clickedButtonTrComplaintIdClass).find(".current-status").removeClass("disabled")
      $(clickedButtonTrComplaintIdClass).find(".current-status").removeClass("current-status")

      $clickedButton.closest("tr").removeClass(oldTrStatusClass)
      $clickedButton.closest("tr").addClass(response.status)
      $clickedButton.addClass("current-status")
      $clickedButton.addClass("disabled")
    })
  })

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
