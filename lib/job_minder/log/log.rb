module JobMinder
  class Log

    def self.setup
      if JobMinder::Config.orm == :sequel
        require_relative 'log_sequel'
      end

      if JobMinder::Config.orm == :active_record
        require_relative 'log_active_record'
      end
    end

    def self.create(data)

      setup

      if JobMinder::Config.orm == :sequel
        @log_object = JobMinder::LogSequel.create(data)
      end

      if JobMinder::Config.orm == :active_record
        @log_object = JobMinder::LogActiveRecord.create(data)
      end

      @log_object
    end
  end
end