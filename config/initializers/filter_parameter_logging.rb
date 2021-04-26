# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]

Rails.application.config.filter_parameters << lambda do |k, v|
  if v.class == String
    max_length = 256 
    # Based in [Media Type Specifications and Registration Procedures](https://tools.ietf.org/html/rfc6838#section-4.2)
    file_match = /^data:(([a-zA-Z]|[$&\-^_!#]){0,127})\/(([a-zA-Z]|[$&\-^_!#+]){0,127});base64,/.match(v)

    if file_match.present?
      v.replace("[FILE] #{file_match}")
    elsif v.length > max_length
      v.replace("#{v.slice(0..max_length - 1)} [MAX_LENGTH #{max_length}]")
    end
  end
end
