class Node < ActiveRecord::Base
  has_ancestry

  include FileFormats

  def files
    children.where('filetype IS NOT NULL')
  end

  def folders
    children.where(filetype: nil)
  end

  def deep_size
    descendants.pluck(:size).inject(0) { |sum, size| sum + size }
  end

  def categories_with_size(nodes = files)
    categories = {}
    nodes.each do |node|
      next if node.category.nil?

      categories[node.category] = 0 unless categories.has_key?(node.category)
      categories[node.category] += node.size
    end

    categories
  end

  def deep_categories_with_size
    categories_with_size(descendants)
  end
end
