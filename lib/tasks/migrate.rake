namespace :migrate do
  desc "Temporary task to migrate diver_samples table to diver_id and buddy_id fields on samples table. This task assumes diver_samples is correct and will overwrite any existing diver_id and buddy_id on the samples table."
  task diver_samples: :environment do
    DiverSample.includes(:sample).find_each do |ds|
      if ds.primary_diver?
        ds.sample.update(diver_id: ds.diver_id)
      else
        ds.sample.update(buddy_id: ds.diver_id)
      end
    end
  end
end
