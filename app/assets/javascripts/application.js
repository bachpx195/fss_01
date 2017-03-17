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
//= require jquery.remotipart
//= require turbolinks
//= require semantic-ui
//= require_tree .
//= require bootstrap-sprockets

$(document).on('turbolinks:load', function(){
  $(".alert").delay(2000).slideUp(500, function(){
      $(".alert").alert('close');
  });
  $('.ui.rating').rating('disable');
});

$(document).on('click', '.like-button', function(e){
  e.preventDefault();
  $(this).next('form').submit();
});

$(document).on('click', '.tab-button', function(e){
  e.preventDefault();
  $('.tab-item.active').removeClass('active');
  let tabname = $(this).attr('data-tab');
  $('[data-tab="'+ tabname +'"]').addClass('active');
});

$(document).on('change', '.user_role', function(){
  var test = $(this).parent().prev().children().attr('id');
  index = $('.user_role option:selected').val();
  $.ajax({
    url: "users/" + test,
    type: "PUT",
    dataType: "script",
    data: {"key": index},
  });
});

$(document).on('change', '.recipe_status', function(){
  var status = $('.recipe_status option:selected').val();
  var recipe_id = $(this).attr('id');
  $.ajax({
    url: "recipes/" + recipe_id,
    type: "PUT",
    dataType: "script",
    data: {status: status},
  });
});

$(document).on('click', '#delete_recipe', function(){
  $.ajax({
    type: 'DELETE',
    dataType: 'script',
  });
});

$(document).on('change', '.filter_recipes_status', function(){
  var filter = $('.filter_recipes_status option:selected').val();
  $.ajax({
    url: "recipes",
    type: "GET",
    dataType: "script",
    data: {"filter": filter},
  });
});

function show_file_preview(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#form-avatar').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('.fields').hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id));
}

$(function() {
  $('#pictureInput').on('change', function(event) {
    var files = event.target.files;
    var image = files[0]
    var reader = new FileReader();
    reader.onload = function(file) {
      var img = new Image();
      img.src = file.target.result;
      img.style.maxHeight = "100px"
      img.style.width = "auto"
      $('#target').html(img);
    }
    reader.readAsDataURL(image);
  });
});
