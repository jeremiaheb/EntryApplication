namespace :drafts do
  desc "Destroy stale drafts to keep the database table smaller"
  task :destroy_stale do
    Draft.destroy_stale
  end
end
