module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def add_body_class(klass)
    @body_classes = Set.new unless defined?(@body_classes)
    @body_classes << klass
  end

  def body_classes
    @body_classes.to_a || []
  end

  def inline_svg(path)
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
