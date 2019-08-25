$(function(){
  $(document).on('click', function(){
    if(!$(event.target).closest(".js-dropdown").length){
      $(".dropdown-menu").slideUp("fast");
    }
  });

  $('.js-dropdown').on('click', function(){
    var $this = $(this);
    $this.children('.dropdown-menu').slideDown("fast")
  });

  $('.js-dropdown .dropdown-item').on('click', function(){
    let $checkbox = $(this).find('input[type="checkbox"]');
    let $checked = $checkbox.prop("checked", !$checkbox.prop("checked"));

    if ( $checked.prop("checked") ) {
      $('.my-tag').append( tag($checked.val()) );
    }
    else {
      $(`.my-tag .tag-${$checked.val()}`).remove();
    }
  });

  function tag(val) {
    return $(`<span class='badge badge-info tag-${val}'>${val}</span>`);
  }
})
