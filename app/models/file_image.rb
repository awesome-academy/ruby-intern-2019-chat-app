class FileImage < ApplicationRecord
  belongs_to :room
  belongs_to :message
  mount_uploader :file, FileUploader

  scope :get_list_files_room, (lambda do |room_id|
    where room_id: room_id
  end)

  def as_json options
    super(options)
      .merge(user_name: message.user.name, file_name: file.url.split("/").last,
             created_time_at: created_at.strftime("%F %T"),
             file_size: file.size, kind: message.kind,
             user_id: message.user_id)
  end
end
