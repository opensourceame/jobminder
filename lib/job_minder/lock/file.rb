module JobMinder
  module Lock
    class File < Lock

      @@lock_dir = '/tmp'

      def set
        ::File.write(lock_file_name, Time.now)
      end

      def unset
        ::File.delete(lock_file_name)
      end

      def is_set?
        ::File.exists?(lock_file_name)
      end

      def lock_file_name
        "#{@@lock_dir}/#{@@lock_prefix}_#{name}.lock"
      end
    end
  end
end