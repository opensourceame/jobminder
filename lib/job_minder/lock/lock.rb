module JobMinder
  module Lock

    def self.new(type, name)
      klass = Object.const_get("JobMinder::Lock::#{type.capitalize}")

      klass.new(name)
    end

    class Lock

      @@lock_prefix = 'job_minder'

      attr_accessor :name

      def initialize(name)
        @name = name
      end

    end
  end
end