module NodeCalculations
  extend ActiveSupport::Concern

  included do
    def deep_size
      return size if file?

      Rails.cache.fetch [id, updated_at] do
        descendants.files.pluck(:size).inject(0) { |sum, size| sum + size }
      end
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
end
