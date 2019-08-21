module JobMinder
  module Lock
    class Redis < Lock

      def set
        redis.set(process_lock_key, Time.now)
      end

      def unset
        redis.del(process_lock_key)
      end

      def is_set?
        redis.get(process_lock_key)
      end

      def process_lock_key
        lock_prefix + ':' + normalize_text(name)
      end

      def redis
        @redis ||= Redis.new
      end
    end
  end
end