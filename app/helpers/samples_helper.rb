module SamplesHelper
  def diver_samples_primary_first(diver_samples)
    [
      diver_samples.find { |ds| ds.primary_diver? } || diver_samples.build(primary_diver: true, diver_id: current_diver.id),
      diver_samples.find { |ds| !ds.primary_diver? } || diver_samples.build(primary_diver: false),
    ].compact
  end
end
