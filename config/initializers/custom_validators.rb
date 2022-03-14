
class FieldFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
      record.errors.add(attr_name, :field_format, options.merge(:value => value))
    end
  end
end

# This allows us to assign the validator in the model
module ActiveModel::Validations::HelperMethods
  def validates_field_format(*attr_names)
    validates_with FieldFormatValidator, _merge_attributes(attr_names)
  end
end
