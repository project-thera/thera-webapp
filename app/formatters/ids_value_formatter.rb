class IdsValueFormatter < JSONAPI::ValueFormatter
  class << self
    def format(arg)
      arg.map{ | id | id.to_s }.as_json
    end

    def unformat(arg)
      arg
    end
  end
end