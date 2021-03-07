class Api::V1::BaseResource < JSONAPI::Resource
  include JSONAPI::Authorization::PunditScopedResource
  # include JSONAPI::Resource::Ransackable

  abstract

  ##
  # This method generates dinamically the necessary methods to make embedded objects work with JSONAPI. 
  # Keep in mind that embebedd objects are not supported by default in JSONAPI.
  # Its based in https://jsonapi-resources.com/v0.10/guide/resources.html#Flattening-a-Rails-relationship
  #
  # = Example
  #   accepts_nested_attributes_for_has_many :annexes, Api::V1::AnnexResource 
  #
  # Generates the writer and reader of association_name, you still have to add accepts_nested_attributes_for in activerecord model
  #
  def self.accepts_nested_attributes_for_has_many(association_name, resource_class)
    attribute_name = :"#{association_name}_attributes"

    attribute attribute_name

    define_method attribute_name do ''
      out = []

      @model.send(association_name).each do | relation |
        attributes = JSONAPI::ResourceSerializer.new(resource_class)
          .serialize_to_hash(resource_class.new(relation, context))
          .dig(:data, 'attributes')

        attributes['id'] = relation.id

        out << attributes
      end

      out
    end

    define_method "#{attribute_name}=" do |association_params|
      jsonapi_attributes = []

      # Clean parameters
      association_params.each do |association_attributes|
        if association_attributes[:id].present?
          jsonapi_attributes << association_attributes.permit(resource_class.updatable_fields(context) + [:id, :_destroy])
        else
          jsonapi_attributes << association_attributes.permit(resource_class.creatable_fields(context) + [:_destroy])
        end
      end

      resources = []

      # FIXME check if there is a better way to handle this without adding +to_nested_attribute+
      # The problem ocurrs when there is a delegate o custom atribute in association resource
      #
      # For example if association has a file attribute in resource wich is delegated to file_id in model,
      # the parameter will be file but nested attributes required to be file_id
      jsonapi_attributes.each do | attributes |
        resource = resource_class.create(context)
        destroy = {}

        attributes.each do | attribute, value |
          if attribute != '_destroy'
            resource.send "#{attribute}=", value
          else
            destroy[attribute] = value
          end
        end

        resources << resource.to_nested_attribute.merge(destroy)
      end

      # Finally asign to the attribute
      @model.send "#{attribute_name}=", resources
    end
  end
end
