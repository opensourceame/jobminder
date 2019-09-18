class JobMinder::LogSequel < Sequel::Model(:jobminder_logs)

  plugin :defaults_setter

  # plugin :serialization, :struct, :data
  # plugin :serialization, :struct, :params

  plugin :serialization, :json, :data
  plugin :serialization, :json, :params

  # default_values[:data]   = OpenStruct.new
  # default_values[:params] = OpenStruct.new

  # def before_save
  #   self[:data]   = @data.to_h.to_json
  #   self[:params] = @params.to_h.to_json
  # end

  # def after_initialize
  #   @params ||= OpenStruct.new(field_to_h(:params))
  #   @data   ||= OpenStruct.new(field_to_h(:data))
  #   binding.pry
  # end
  #


  def field_to_h(field)
    return {} if self[field.to_sym].nil?

    JSON.load(self[field.to_sym])
  end

end

