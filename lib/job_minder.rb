require_relative 'job_minder/job'
require_relative 'job_minder/lock/lock'
require_relative 'job_minder/lock/file'
require_relative 'job_minder/lock/redis'
require_relative 'job_minder/log/log'
require_relative "job_minder/version"

module JobMinder

  @@lock_type = :file

  def self.new_job(name, **options)
    Job.new(name, options)
  end

  def self.lock_type
    @@lock_type
  end

  def self.normalize_text(text)
    return '' if text.nil?
    return text.to_s.gsub(/\P{Word}+/, '').downcase
  end
end