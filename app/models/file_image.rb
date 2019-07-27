class FileImage < ApplicationRecord
  belongs_to :room
  belongs_to :message
  mount_uploader :file, FileUploader

  def as_json options
    super(options)
      .merge(user_name: message.user.name, file_name: file.url.split("/").last,
             created_time_at: created_at.strftime("%F %T"),
             file_size: file.size, kind: message.kind,
             user_id: message.user_id)
  end
end
