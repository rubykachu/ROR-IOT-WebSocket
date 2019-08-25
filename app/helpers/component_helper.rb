module ComponentHelper
  def component(component_name, attrs = {}, &block)
    if attrs.key?(:collection)
      partial = component_name.split('/').last.singularize
      partial = attrs[:partial] if attrs[:partial].present?
      path = "components/#{component_name}/#{partial}"
      render partial: path, collection: attrs[:collection], as: attrs[:as], locals: attrs[:locals]
    else
      partial = component_name.split('/').last
      render("components/#{component_name}/#{partial}", attrs, &block)
    end
  end

  alias c component
end
