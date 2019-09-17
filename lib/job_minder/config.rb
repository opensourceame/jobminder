module JobMinder
  class Config

    @@orm = :active_record

    def self.orm
      @@orm
    end

    def self.orm=(type)
      @@orm = type
    end

  end
end