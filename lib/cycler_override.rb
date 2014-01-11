module ::Backup
  module Storage
    module Cycler
      private
      ##
      # Updates the YAML data file according to the #keep setting
      # for the storage and sets the @packages_to_remove
      def self.update_storage_file!
        packages = yaml_load
        if @storage.keep.is_a? Proc
          @packages_to_remove = packages - packages.reject { |pkg| @storage.keep.call pkg }
          packages = packages - @packages_to_remove
        else
          packages = packages.unshift(@package)
          excess = packages.count - @storage.keep.to_i
          @packages_to_remove = (excess > 0) ? packages.pop(excess) : []
        end
        yaml_save(packages)
      end
    end

    class CloudFiles
      private

      def cycle!
        return if !(keep.is_a? Proc) && keep.to_i <= 0
        Logger.info "Cycling Started..."
        Cycler.cycle!(self)
      end
    end
  end
end