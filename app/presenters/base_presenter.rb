class BasePresenter < SimpleDelegator
  def initialize(model, view)
    @model, @view = model, view
    super(model)
  end

  def h
    @view
  end

  private

  attr_reader :model, :view
end
