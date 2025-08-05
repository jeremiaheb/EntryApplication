class Animal < ActiveRecord::Base
  has_many :sample_animals, dependent: :restrict_with_error
  has_many :samples, through: :sample_animals

  validates :species_code,    presence: true
  validates :scientific_name, presence: true
  validates :common_name,     presence: true
  validates :max_size,        presence: true
  validates :min_size,        presence: true
  validates :max_number,      presence: true

  def spp_code_common
    "#{species_code} __ #{common_name}"
  end

  # Name to use when generating report
  def report_name(name_type)
    case name_type
    when "common_name"
      common_name
    else
      species_code
    end
  end
end
