class Api::V1::PatientVideoResource < Api::V1::BaseResource
  attributes :video, 
    :created_at,
    :updated_at
  
  # has_one :patient

  before_save do
    if context[:user].patient? && @model.new_record?
      @model.patient_id = context[:user].id
    end
  end

  def fetchable_fields
    super - [:video]
  end

  def custom_links(options)
    { video: options[:serializer].link_builder.self_link(self) + "/video" }
  end
end