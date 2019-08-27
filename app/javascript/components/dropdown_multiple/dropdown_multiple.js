import "./dropdown_multiple.scss";

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
    let $this  = $(this);
    let disabled = $this.data('disabled');

    if (disabled) { return false; }

    let $checkbox = $this.find('input[type="checkbox"]');
    let $checked = $checkbox.prop("checked", !$checkbox.prop("checked"));
    let checkbox_id = $checkbox.val();
    let checkbox_text = $checkbox.data('text');

    if ( $checked.prop("checked") ) {
      $(".my-tag").append( tag(checkbox_id, checkbox_text) );
    }
    else {
      $(`.my-tag .tag-${checkbox_id}`).remove();
    }
  });

  $('.dropdown-item input:checkbox:checked').each(function(e) {
    let $this = $(this);
    let checkbox_id = $this.val();
    let checkbox_text = $this.data('text')
    $(".my-tag").append( tag(checkbox_id, checkbox_text) );
  });

  function tag(id, text) {
    return $(`<span class='badge badge-info tag-${id}'>${text}</span>`);
  }
})
