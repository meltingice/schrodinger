class Node < ActiveRecord::Base
  has_ancestry touch: true

  include NodeAncestry
  include NodeCalculations
  include FileFormats

  scope :files, -> { where('filetype IS NOT NULL') }
  scope :folders, -> { where(filetype: nil) }

  def file_ext
    Pathname.new(name).extname[1..-1]
  end

  def file?
    filetype.present?
  end

  def folder?
    filetype.nil?
  end
end
