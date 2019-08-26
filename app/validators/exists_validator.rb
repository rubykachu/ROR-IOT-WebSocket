class ExistsValidator < ActiveRecord::Validations::UniquenessValidator
  def validate_each(record, attribute, value)
    model = options[:with] || attribute.to_s.titleize.delete(' ')
    model = model.constantize
    return if model.exists?(value)
    record.errors.add(attribute, :blank)
  end
end
