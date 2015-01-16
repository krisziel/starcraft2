$(document).ready(function(){
  $('#clan-tag').focus();
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
        $('#clan-members').html('<li class="title">Clan Members<div id="save-clan-button" class="save-clan-button">Save</div></li>');
        $("#save-clan-button").click(function(){ saveClan({tag:data.tag}); })
        for(i=0;i<members.length;i++) {
          row = members[i];
          thisRow = '<li>' + row.tag + ' ' + row.name + '<div class="league-small ' + row.league + ' top8"></div><div class="race-small ' + row.race + '-small"></div><div class="blank-space">&nbsp;</div></li>';
          list.append(thisRow);
        }
      }
    }
    $('#clan-search-loading').removeClass('visible');
  },'json');
}

function saveClan(args) {
  if(!args || !args.tag) {
    return false;
  }
  $('#save-clan-button').addClass('loading-button');
  $.post('clans/create/', { tag:args.tag }, function(data) {
    $('#save-clan-button').removeClass('loading-button').html("Created");
    loadClan(data.id);
  });
}

function loadClan(args) {
  $('#clan-search-loading').addClass('visible');
  $.post('clans/.json', { tag:args.tag }, function(data) {
    $('body').append('<div class="profile"></div>');
    $('.profile').css({display:'block',opacity:1});
    $('#clan-search-loading').addClass('visible');
  },'json');
}

// jQuery('<li/>', {
//   id: 'ladder' + team.id,
//   class: team.id,
//   html: ladderRow
// })
