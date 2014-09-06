class BasePresenter
  def self.presents(type)
    define_method(type) { @object }
  end

  attr_reader :object

  def initialize(object, template)
    @object = object
    @template = template
  end

  def h
    @template
  end
end
