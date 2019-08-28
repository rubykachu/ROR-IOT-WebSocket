class ExistsValidator < ActiveRecord::Validations::UniquenessValidator
  def validate_each(record, attribute, value)
    if options[:array].blank?
      model = options[:model] || attribute.to_s.titleize.delete(' ')
      model = model.constantize
      key   = options[:key].presence || :id
      return if model.exists?(key => value)
      record.errors.add(attribute, :dont_exist)
    end

    if options[:array].present?
      model = options[:model] || attribute.to_s.titleize.split(' ').first
      model = model.constantize
      key = options[:key].presence || :id
      count = model.where(key => value).count
      return if count == value.size
      record.errors.add(attribute, :dont_exist)
    end
  end
end
