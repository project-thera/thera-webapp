JSONAPI.configure do |config|
  config.json_key_format = :underscored_key
  config.route_format = :underscored_route

  config.allow_include = true
  config.allow_sort = true
  config.allow_filter = true

  config.raise_if_parameters_not_allowed = true

  config.default_paginator = :paged

  config.top_level_links_include_pagination = true

  config.default_page_size = 10
  config.maximum_page_size = 50

  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :record_count

  config.use_text_errors = true

  config.exception_class_whitelist = []

  config.always_include_to_one_linkage_data = false

  config.default_processor_klass = JSONAPI::Authorization::AuthorizingProcessor
  config.exception_class_whitelist = [Pundit::NotAuthorizedError]
end