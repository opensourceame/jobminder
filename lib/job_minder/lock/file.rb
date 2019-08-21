module JobMinder
  module Lock
    class File < Lock

      @@lock_dir = '/tmp'

      def set
        ::File.write("#{@@lock_dir}/#{@@lock_prefix}_#{name}", Time.now)

        binding.pry
      end
    end
  end
end