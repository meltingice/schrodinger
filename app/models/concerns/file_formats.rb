module FileFormats
  extend ActiveSupport::Concern

  included do
    EXT_TO_CATEGORY = {
      'psd' =>    'design',
      'ai' =>     'design',
      'sketch' => 'design',
      'pdf' =>    'document',
      'doc' =>    'document',
      'docx' =>   'document',
      'pptx' =>   'document',
      'pages' =>  'document',
      'numbers' =>'document',
      'keynote' =>'document',
      'rtf' =>    'document',
      'txt' =>    'document',
      'zip' =>    'archive',
      '7z' =>     'archive',
      'rar' =>    'archive',
      'mp4' =>    'video',
      'mov' =>    'video',
      'html' =>   'web',
      'htm' =>    'web',
      'css' =>    'web',
      'scss' =>   'web',
      'sass' =>   'web',
      'js' =>     'code',
      'rb' =>     'code',
      'py' =>     'code',
      'php' =>    'code',
      'c' =>      'code',
      'cpp' =>    'code',
      'm' =>      'code',
      'h' =>      'code'
    }

    def category
      return nil if filetype.nil?
      guess_category || filetype.split('/').first
    end

    private

    def guess_category
      if EXT_TO_CATEGORY.has_key?(file_ext)
        return EXT_TO_CATEGORY[file_ext]
      end

      nil
    end
  end
end
