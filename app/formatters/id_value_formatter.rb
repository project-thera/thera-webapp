class IdValueFormatter < JSONAPI::ValueFormatter
  class << self
    def format(arg)
      arg.to_s.as_json
    end

    def unformat(arg)
      arg
    end
  end
end