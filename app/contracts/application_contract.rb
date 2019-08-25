class ApplicationContract
  include ActiveModel::Model
  include ActiveModel::Validations
  include Virtus.model

  def self.new(options)
    object = super
    object.after_initialize
    object
  end

  def after_initialize; end
  def after_valid; end

  def invalid?
    clean_attributes
    self.after_valid
    !valid?
  end

  def clean_attributes
    record_attributes = record.attribute_names.map(&:to_sym)
    except_attributes = attributes.keys - record_attributes
    record.assign_attributes(attributes.except(*except_attributes))
    record
  end
end
