class Node < ActiveRecord::Base
  has_ancestry

  def files
    children.where('filetype IS NOT NULL')
  end

  def folders
    children.where(filetype: nil)
  end
end
