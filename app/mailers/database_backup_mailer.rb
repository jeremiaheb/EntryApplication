class DatabaseBackupMailer < ApplicationMailer
  default to: ["andy.lindeman@noaa.gov", "jeremiah.blondeau@noaa.gov"]

  def backup
    @now = Time.zone.now
    @hostname = Socket.gethostname

    attachments["backup_#{@hostname.split(/\./).first}_#{@now.strftime("%Y-%m-%d")}.dump"] = {
      mime_type: "application/octet-stream",
      content: params[:content],
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
