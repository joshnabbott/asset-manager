# TODO: Return scale image if it exists.
require 'digest/md5'
module Paperclip
  class Attachment
    def scale_to(scale_to)
      file_extension = File.extname(self.path)
      file_name      = "#{Digest::MD5.hexdigest([self.instance.file_file_name, scale_to, file_extension].join)}"
      path           = File.join(RAILS_ROOT, 'public')
      url            = File.join('system', 'tmp')
      full_path      = [path, url, file_name].join('/')
      if File.exist?(full_path)
        return '/' + [url, file_name].join('/')
      else
        `convert #{self.path} -resize #{scale_to}% -strip #{full_path}`
        return '/' + [url, file_name].join('/')
      end
    end
  end
end