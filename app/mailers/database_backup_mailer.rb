class DatabaseBackupMailer < ApplicationMailer
  default to: ["andy.lindeman@noaa.gov", "jeremiah.blondeau@noaa.gov"]

  def backup
    @now = Time.zone.now
    @hostname = Socket.gethostname

    @filename = "backup_#{params[:identifier]}.dump"
    attachments[@filename] = {
      mime_type: "application/octet-stream",
      content: params[:io].read,
    }

    mail(subject: "Database Backup")
  end

  def backup_failed
    @now = Time.zone.now
    @hostname = Socket.gethostname
    @stdout_s = params[:stdout_s]
    @stderr_s = params[:stderr_s]

    mail(subject: "[Important] Database Backup FAILED")
  end
end
