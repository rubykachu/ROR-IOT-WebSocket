class UniqueValidator < ActiveRecord::Validations::UniquenessValidator
  def validate_each(form, attribute, value)
    record = form.record
    # search for models with attribute equals to form field value
    query = if options[:case_sensitive] == false && value
              record.class.where("lower(#{attribute}) = ?", value.downcase)
            else
              record.class.where(attribute => value)
            end

    # if model persisted, query should bypass model
    if record.persisted?
      query = query.where("#{record.class.primary_key} != ?", record.id)
    end

    # apply scope if options has been declared
    Array(options[:scope]).each do |field|
      # add condition to only check unique value with the same scope
      query = query.where(field => form.send(field))
    end
    message = options[:message].presence || :taken
    form.errors.add(attribute, message) if query.count > 0
  end
end
