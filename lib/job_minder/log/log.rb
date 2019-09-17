# require 'pry'

# require_relative 'log_sequel'        if JobMinder::Config.orm == :sequel
# require_relative 'log_active_record' if JobMinder::Config.orm == :active_record

# require_relative 'log_sequel'        if defined?(Sequel)       || JobMinder::Config.orm == :sequel
# require_relative 'log_active_record' if defined?(ActiveRecord) || JobMinder::Config.orm == :active_record

module JobMinder
  class Log

    def self.create(data)

      require_relative 'log_sequel' if defined?(Sequel) || JobMinder::Config.orm == :sequel
      require_relative 'log_active_record' if defined?(ActiveRecord) || JobMinder::Config.orm == :active_record

      @log_object = JobMinder::LogSequel.new

      binding.pry
    end


    def persist

    end
  end
end