require_relative 'job_minder/config'
require_relative 'job_minder/job'
require_relative 'job_minder/lock/lock'
require_relative 'job_minder/lock/file'
require_relative 'job_minder/lock/redis'
require_relative 'job_minder/log/log'
require_relative "job_minder/version"

module JobMinder

  @@lock_type = :file
  @@orm       = :active_record

  def self.lock_type
    @@lock_type
  end

  def self.orm
    @@orm
  end

  def self.orm=(type)
    @@orm = type
  end

  def self.normalize_text(text)
    return '' if text.nil?
    return text.to_s.gsub(/\P{Word}+/, '').downcase
  end
end