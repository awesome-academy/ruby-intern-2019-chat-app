$(function () {
  $('[data-channel-subscribe="room"]').each(function (index, element) {
    var $element = $(element),
      room_id = $element.data('room-id');
    take_part_in_stream_room(room_id);
  });
});

function take_part_in_stream_room(room_id) {
  App.cable.subscriptions.create(
    {
      channel: "RoomChannel",
      room_id: room_id
    },
    {
      connected: function () {
      },
      disconnected: function () {
      },
      received: function (data) {
        var preview_chat;

        if (data.kind == 0) {
          if (data.user_id != gon.current_user_id) {
            $('<li class="replies" data-toggle="tooltip" title="' + data.user_name + " " + data.created_time_at + '"><img src="/assets/avatar_default-60f4ddba4688f232aae522362d6b7b50f4409493657563207aae202fa3aee263.png" class="avatar-right"><p>' + data.content + '</p></li>').appendTo($('.content_room_chat_' + data.room_id + ' ul'));
            preview_chat = '<span>' + data.user_name + ': </span>' + data.content
          } else {
            $('<li class="sent" data-toggle="tooltip" title="' + data.user_name + " " + data.created_time_at + '"><img src="/assets/avatar_default-60f4ddba4688f232aae522362d6b7b50f4409493657563207aae202fa3aee263.png" class="avatar-left"><p>' + data.content + '</p></li>').appendTo($('.content_room_chat_' + data.room_id + ' ul'));
            preview_chat = '<span>You: </span>' + data.content
          }
        } else {
          if (data.user_id != gon.current_user_id) {
            $('<li class="replies" data-toggle="tooltip" title="' + data.user_name + " " + data.created_time_at + '"><img src="/assets/avatar_default-60f4ddba4688f232aae522362d6b7b50f4409493657563207aae202fa3aee263.png" class="avatar-right"><div class="content-chat-file">' +
              '<img class="avatar-file" src="https://vtask.net/img/icon_file_other.png" class="icon-type-file"><div class="step-content-chat-file"><a target="_blank" href="'
              + data.file.url +
              '">'
              + data.file_name +
              '</a></div>' +
              '<div class="step-content-size-save">' +
              '<span>' + data.file_size + 'Kb</span>' +
              '</div>' +
              '</div>' +
              '</li>')
              .appendTo($('.content_room_chat_' + data.room_id + ' ul'));
            preview_chat = '<span>' + data.user_name + ': </span> Đã tải lên 1 file'
          } else {
            $('<li class="sent" data-toggle="tooltip" title="' + data.user_name + " " + data.created_time_at + '"><img src="/assets/avatar_default-60f4ddba4688f232aae522362d6b7b50f4409493657563207aae202fa3aee263.png" class="avatar-left"><div class="content-chat-file">' +
              '<img class="avatar-file" src="https://vtask.net/img/icon_file_other.png" class="icon-type-file"><div class="step-content-chat-file"><a target="_blank" href="' + data.file.url + '"><p>' + data.file_name + '</p> </a></div>' +
              '<div class="step-content-size-save">' +
              '<span>' + data.file_size + 'Kb</span>' +
              '</div>' +
              '</div>' +
              '</li>')
              .appendTo($('.content_room_chat_' + data.room_id + ' ul'));
            preview_chat = '<span>You: </span> Đã tải lên 1 file'

          }
        }
        $('.contact#room_chat_' + data.room_id + ' .meta .preview').html(preview_chat);

        var tab_room_choice = $('#frame .content').attr('data-room-id');

        if (data.room_id != tab_room_choice)
        {
          $('.img-new-message-'+data.room_id).show();
        }
        else
          $('.img-new-message-'+data.room_id).hide();

        $(".messages").animate({
          scrollTop: $('.messages')[0].scrollHeight
        }, "fast");
      }
    }
  )
  ;
}
