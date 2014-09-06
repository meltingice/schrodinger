class Node < ActiveRecord::Base
  has_ancestry

  def files
    children.where('filetype IS NOT NULL')
  end

  def folders
    children.where(filetype: nil)
  end

  def deep_size
    descendants.pluck(:size).inject(0) { |sum, size| sum + size }
  end
end
