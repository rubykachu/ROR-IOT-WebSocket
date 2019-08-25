class ApplicationContract
  include ActiveModel::Model
  include ActiveModel::Validations
  include Virtus.model

  # def self.new(options)
  #   super
  # end

  def clean_attributes
    record_attributes = record.attribute_names.map(&:to_sym)
    except_attributes = attributes.keys - record_attributes
    record.assign_attributes(attributes.except(*except_attributes))
    record
  end

  def invalid?
    clean_attributes
    !valid?
  end
end
