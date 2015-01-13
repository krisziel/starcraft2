$(document).ready(function(){
  $("form").submit(function(event) {
    searchClan({tag:$('#clan-tag').val()})
    event.preventDefault();
  });
})

function searchClan(args) {
  $('#clan-search-loading').addClass('visible');
  $.post('clans/search/', { tag:args.tag }, function(data) {
    if($('#clan-members').length > 0) {
      $('#clan-members').html('');
    } else {
      $('#clan-search').after('<ul class="clan-members" id="clan-members"></ul>');
    }
    if(data.id) {
      loadClan({tag:data.tag,id:data.id});
    } else {
      var members = data.members;
      var list = $('#clan-members');
      $(".clan-search").addClass('members');
      if(members.length === 0) {
        list.html('<li class="title">Clan Not Found</li>')
      } else {
        $('#clan-members').html('<li class="title">Clan Members</li>');
        for(i=0;i<members.length;i++) {
          row = members[i];
          thisRow = '<li><div class="league-small ' + row.league + ' top8"></div><div class="race-small ' + row.race + '-small"></div>' + row.tag + ' ' + row.name + '</li>';
          list.append(thisRow)
        }
      }
    }
    $('#clan-search-loading').removeClass('visible');
  },'json');
}

function loadClan(args) {
  $('#clan-search-loading').addClass('visible');
  $.post('clans/.json', { tag:args.tag }, function(data) {
    $('#clan-search-loading').addClass('visible');
  },'json');
}
