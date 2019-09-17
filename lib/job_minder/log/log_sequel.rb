class JobMinder::LogSequel < Sequel::Model(:jobminder_logs)

  def before_save
    self[:data]   = Hash.new(@data).to_json
    self[:params] = Hash.new(@params).to_json
  end

  def params
    @params ||= OpenStruct.new(self[:params].nil? ? {} : JSON.load(self[:params]))
  end
  
  def data
    @data ||= OpenStruct.new(self[:data].nil? ? {} : JSON.load(self[:data]))
  end
  
end