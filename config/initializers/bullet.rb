Rails.application.config.after_initialize do
  # Report on possible N+1 queries in development and test environments
  case Rails.env
  when "development":
    Bullet.enable        = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  when "test":
    Bullet.enable        = true
    Bullet.bullet_logger = true
  end
end
