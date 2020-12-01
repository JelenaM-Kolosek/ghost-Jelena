 jQuery ->
  $('.search-field').autocomplete
    appendTo: '.search-form',
    source: '/search_suggestions'