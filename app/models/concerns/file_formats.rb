module FileFormats
  extend ActiveSupport::Concern

  included do
    EXT_TO_CATEGORY = {
      'psd' =>    'design',
      'ai' =>     'design',
      'sketch' => 'design',
      'eps' =>    'design',
      'pdf' =>    'document',
      'doc' =>    'document',
      'docx' =>   'document',
      'pptx' =>   'document',
      'pages' =>  'document',
      'numbers' =>'document',
      'key' =>    'document',
      'rtf' =>    'document',
      'txt' =>    'document',
      'graffle' =>'document',
      'zip' =>    'archive',
      '7z' =>     'archive',
      'rar' =>    'archive',
      'bak' =>    'archive',
      'bz2' =>    'archive',
      'cip' =>    'archive',
      'dead' =>   'archive',
      'dmg' =>    'archive',
      'iso' =>    'archive',
      'gnu' =>    'archive',
      'gzip' =>   'archive',
      'gz' =>     'archive',
      'pkg' =>    'archive',
      'tar' =>    'archive',
      'tgz' =>    'archive',
      'z64' =>    'game',
      'n64' =>    'game',
      'smd' =>    'game',
      'mp4' =>    'video',
      'mov' =>    'video',
      'html' =>   'web',
      'htm' =>    'web',
      'css' =>    'web',
      'scss' =>   'web',
      'sass' =>   'web',
      'less' =>   'web',
      'js' =>     'code',
      'coffee' => 'code',
      'rb' =>     'code',
      'py' =>     'code',
      'php' =>    'code',
      'c' =>      'code',
      'cpp' =>    'code',
      'm' =>      'code',
      'h' =>      'code',
      'json' =>   'code',
      'makefile' => 'code',
      'abf' =>    'font',
      'acfm' =>   'font',
      'afm' =>    'font',
      'amfm' =>   'font',
      'bdf' =>    'font',
      'cha' =>    'font',
      'compositefont' => 'font',
      'dfont' =>  'font',
      'eot' =>    'font',
      'etx' =>    'font',
      'euf' =>    'font',
      'ffil' =>   'font',
      'fnt' =>    'font',
      'fon' =>    'font',
      'fot' =>    'font',
      'gf' =>     'font',
      'glif' =>   'font',
      'lwfn' =>   'font',
      'otf' =>    'font',
      'pfa' =>    'font',
      'pfb' =>    'font',
      'pfm' =>    'font',
      'pfr' =>    'font',
      'pmt' =>    'font',
      'sfd' =>    'font',
      'suit' =>   'font',
      'tfm' =>    'font',
      'ttc' =>    'font',
      'ttf' =>    'font',
      'vfb' =>    'font',
      'vfbak' =>  'font',
      'woff' =>   'font',
      '1password' => 'config',
      'cfg' =>    'config'
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
