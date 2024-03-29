class ApplicationContract
  include ActiveModel::Model
  include ActiveModel::Validations
  include Virtus.model

  def self.new(options)
    object = super
    strip_params!(options)
    object.after_initialize
    object
  end

  def after_initialize; end
  def before_valid; end

  def invalid?
    self.before_valid
    clean_attributes
    !valid?
  end

  def clean_attributes
    record_attributes = record.attribute_names.map(&:to_sym)
    except_attributes = attributes.keys - record_attributes
    record.assign_attributes(attributes.except(*except_attributes))
    record
  end

  private

  def self.strip_params!(attributes)
    attributes.except(:record).values.flatten.collect &:squish!
  end
end
