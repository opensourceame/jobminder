module JobMinder
  class Job
    class Error < StandardError;
    end

    attr_reader :name, :options, :start_time, :stop_time, :status, :job_log
    attr_accessor :results

    NON_UNICODE_REGEXP = /\P{Word}+/

    @@lock_prefix = 'job'

    def initialize(name, **options)
      @name       = JobMinder.normalize_text(name)
      @status     = :started
      @options    = options
      @results    = {}
      @start_time = Time.now
      @stop_time  = nil

      if options[:process_lock]

        if process_lock.is_set?
          raise StandardError, "job [#{name}] is already running!"
        end

        process_lock.set
      end

      if block_given?
        create_job_log

        yield(self)

        @stop_time = Time.now

        update_job_log(status: :complete)

        at_exit do
          process_lock.unset
        end
      end

    rescue

      @stop_time = Time.now
      binding.pry
      process_lock.unset if @process_lock

      job_log.update(status: :failed)

      raise
    end

    def log(name, datum)
      job_log.result[:name] = datum
    end

    def process_lock
      @process_lock ||= JobMinder::Lock.new(JobMinder.lock_type, name)
    end

    def self.configure(**options)
      @@lock_prefix = options[:lock_prefix] || @@lock_prefix
    end

    def self.unlock(name)
      job = self.new(name)
      job.unset_process_lock
    end

    def elapsed
      (stop_time || Time.now) - start_time
    end

    def create_job_log

      @job_log =
          Log.create(
              name:       name,
              status:     status,
              start_time: start_time,
          )
    end

    def update_job_log(**options)
      attributes = {
          stop_time: Time.now,
          results:   @results,
      }

      attributes.merge!(options) if options.is_a?(Hash)

      job_log.update(
          status: status,
      )
    end

    private

    def normalize_text(input)
      return '' if input.nil?
      return input.gsub(NON_UNICODE_REGEXP, '').downcase
    end

    def lock_prefix
      options[:lock_prefix] || @@lock_prefix
    end

  end
end