class SampleLengthHistogram
  # Creates a histogram comparing the set of sample_animals with a broader set
  # of all_sample_animals.
  #
  # Typically sample_animals will be the set for the current diver and
  # all_sample_animals will be the set for all divers.
  def initialize(sample_animals, all_sample_animals, density_range)
    @sample_animals = sample_animals
    @all_sample_animals = all_sample_animals
    @density_range = density_range
  end

  def as_plotly_data
    lengths = @sample_animals.flat_map { |sa| sample_animal_lengths(sa) }
    all_lengths = @all_sample_animals.flat_map { |sa| sample_animal_lengths(sa) }

    kde_bandwidth = 0.9

    kde_x = @density_range.step((@density_range.last - @density_range.first) / 256.0)
    kde_y = kde_x.map { |x| kde_at_point(lengths, kde_bandwidth, x) }

    all_kde_x = @density_range.step((@density_range.last - @density_range.first) / 256.0)
    all_kde_y = kde_x.map { |x| kde_at_point(all_lengths, kde_bandwidth, x) }

    [
      {
        name: "Sizes",
        type: "histogram",
        x: @sample_animals.flat_map { |sa| sample_animal_lengths(sa) },
        xbins: {
          size: 1,
        },
        histnorm: "probability density",
        marker: {
          color: "rgb(100, 100, 100, 0.5)",
        },
        showlegend: false,
      },
      {
        name: "Density",
        type: "scatter",
        x: kde_x,
        y: kde_y,
        mode: "lines",
        marker: {
          color: "rgb(0, 0, 255, 1.0)",
        },
        # hoverinfo: "none",
      },
      {
        name: "Density (all divers)",
        type: "scatter",
        x: all_kde_x,
        y: all_kde_y,
        mode: "lines",
        marker: {
          color: "rgb(255, 0, 0, 1.0)",
        },
        # hoverinfo: "none",
      },
    ]
  end

  private

  def sample_animal_lengths(sample_animal)
    if sample_animal.number_individuals == 1
      [sample_animal.average_length].compact
    elsif sample_animal.number_individuals == 2
      [sample_animal.min_length, sample_animal.max_length].compact
    else
      [sample_animal.min_length, sample_animal.average_length, sample_animal.max_length].compact
    end
  end

  def kde_at_point(data, bandwidth, x)
    # Force use floating point arithmetic when bandwidth is involved
    bandwidth = bandwidth.to_f

    sum = data.inject(0) { |sum, xi|
      sum + gaussian_kernel((x - xi) / bandwidth)
      # sum + epanechnikov_kernel((x - xi) / bandwidth)
    }

    (1.0 / (data.length * bandwidth)) * sum
  end

  ONE_OVER_SQRT_2_PI = (1.0 / Math.sqrt(2 * Math::PI))
  def gaussian_kernel(u)
    ONE_OVER_SQRT_2_PI * Math.exp(-(u*u) / 2.0)
  end

  def epanechnikov_kernel(u)
    return 0 if u.abs > 1

    (0.75) * (1.0 - u*u)
  end
end
