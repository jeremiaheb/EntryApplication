class FieldidValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value =~ /\d\d\d\d[A-Z]/
      record.errors.add(attr_name, :field_id, options.merge(:value => value))
    end
  end
end

# This allows us to assign the validator in the model
module ActiveModel::Validations::HelperMethods
  def validates_fieldid(*attr_names)
    validates_with FieldidValidator, _merge_attributes(attr_names)
  end
end
