# Tutorial: http://railscasts.com/episodes/287-presenters-from-scratch

class ApplicationPresenter < SimpleDelegator
  include ApplicationHelper

  def initialize(object, view)
    @object, @view = object, view
    super(object)
  end

  private

  attr_reader :object, :view

  def self.presenter(name)
    define_method(name) do
      @object
    end
  end

  def h
    @view
  end
end
