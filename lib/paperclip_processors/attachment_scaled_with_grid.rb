require 'digest/md5'
module Paperclip
  class Attachment
    def logger; RAILS_DEFAULT_LOGGER; end

    TMP_DIR = {
      :absolute_path => File.join(RAILS_ROOT, 'public', 'system', 'tmp'),
      :relative_path => File.join('/system', 'tmp')
    }

    def add_grid!
      system("sh #{RAILS_ROOT}/script/grid.sh -s #{(self.instance.width * (@scale_to.to_f / 100) / 6).floor},#{(self.instance.height * (@scale_to.to_f / 100) / 6).floor} #{self.outfile_with_path(true)} #{self.outfile_with_path(true)}")
      return $CHILD_STATUS.exitstatus == 0 ? true : false
    end

    def basename
      @basename ||= File.basename(self.path, self.extension_name)
    end

    def extension_name
      File.extname(self.path)
    end

    def outfile
      @outfile ||= [Digest::MD5.hexdigest([self.basename, @scale_to, self.extension_name].join), self.extension_name].join
    end

    def outfile_with_path(absolute = false)
      @outfile_with_full_path || File.join(TMP_DIR[absolute ? :absolute_path : :relative_path], outfile)
    end

    def scale!
      system("convert #{self.path} -strip -resize #{@scale_to}% #{self.outfile_with_path(true)}")
      return $CHILD_STATUS.exitstatus == 0 ? true : false
    end

    def scale_to(scale_to)
      @scale_to = scale_to
      if File.exist?(self.outfile_with_path(true))
        return self.outfile_with_path
      else
        # if self.scale! && self.add_grid!
        if self.scale!
          return self.outfile_with_path
        else
          logger.debug("Attachment#scale_to failed with status code #{$CHILD_STATUS.exitstatus}")
        end
      end
    end
  end
end