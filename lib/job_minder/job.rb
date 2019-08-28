module JobMinder
  class Job
    class Error < StandardError;
    end

    attr_reader :name, :config, :start_time, :stop_time, :status, :job_log
    attr_accessor :results

    NON_UNICODE_REGEXP = /\P{Word}+/

    @@lock_prefix = 'job'

    def initialize(name, **options)
      @name       = JobMinder.normalize_text(name)
      @status     = :started
      @config     = OpenStruct.new(options)
      @results    = {}
      @start_time = Time.now
      @stop_time  = nil

      raise StandardError, "job code is empty" unless block_given?

      if config.process_lock

        if process_lock.is_set?
          raise StandardError, "job [#{name}] is already running!"
        end

        process_lock.set
      end

      create_job_log

      yield(self)

      @stop_time = Time.now

      update_job_log(status: :complete, stop_time: stop_time) if @job_log

      at_exit do
        unset_process_lock
      end

    rescue

      @stop_time = Time.now

      unset_process_lock

      update_job_log(status: :failed, stop_time: stop_time) if @job_log

      raise
    end

    def unset_process_lock
      process_lock.unset if config.process_lock && process_lock.is_set?
    end

    def log(name, datum)
      job_log.data[:name] = datum
    end

    def data
      job_log.data
    end

    def params
      job_log.params
    end

    def process_lock
      @process_lock ||= JobMinder::Lock.new(config.lock_type || JobMinder.lock_type, name)
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
          ::JobMinder::Log.create(
              name:       name,
              status:     status,
              start_time: start_time,
          )
    end

    def update_job_log(**options)
      attributes = {
          stop_time: Time.now,
      }

      attributes.merge!(options) if options.is_a?(Hash)

      job_log.update(attributes)
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