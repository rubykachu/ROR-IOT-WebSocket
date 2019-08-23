module ComponentHelper
  def component(component_name, locals = {}, &block)
    if locals.key?(:collection)
      partial = component_name.split('/').last.singularize
      partial = locals[:partial] if locals[:partial].present?
      path = "components/#{component_name}/#{partial}"
      render partial: path, collection: locals[:collection], as: locals[:as], locals: locals[:locals]
    else
      partial = component_name.split('/').last
      render("components/#{component_name}/#{partial}", locals, &block)
    end
  end

  alias c component
end
