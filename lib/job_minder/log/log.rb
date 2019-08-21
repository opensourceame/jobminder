require_relative 'log_sequel'        if defined?(Sequel)
require_relative 'log_active_record' if defined?(ActiveRecord)