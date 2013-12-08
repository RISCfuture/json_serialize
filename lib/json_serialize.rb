# Adds the {#json_serialize} method to @ActiveRecord@ objects.
#
# @example Basic usage
#   class MyModel < ActiveRecord::Base
#     include JsonSerialize
#     json_serialize :some_field, another_field: "Default value"
#   end

module JsonSerialize
  extend ActiveSupport::Concern

  module ClassMethods
    # @overload json_serialize(field, ..., fields_with_default_values)
    #   Marks one or more fields as JSON-serialized. These fields are stored in
    #   the database as JSON and encoded/decoded automatically upon read/write.
    #   @param [Symbol] field The database field to JSON-serialize.
    #   @param [Hash<Symbol, Object>] fields_with_default_values A map of
    #     additional fields to JSON-serialize, with the default value that
    #     should be given if the field is @NULL@.

    def json_serialize(*fields)
      fields_with_defaults = fields.extract_options!
      fields.each do |field|
        fields_with_defaults[field] = nil
      end

      fields_with_defaults.each do |field, default_value|
        define_method field do
          if instance_variable_defined?(field_ivar(field)) then
            instance_variable_get field_ivar(field)
          else
            encoded = read_attribute(field)
            default = default_value.kind_of?(Proc) ? default_value.call : (default_value.duplicable? ? default_value.dup : default_value)
            decoded = encoded.nil? ? default : ActiveSupport::JSON.decode(encoded)
            instance_variable_set field_ivar(field), decoded
            decoded
          end
        end

        define_method :"#{field}=" do |value|
          write_attribute field, (value.nil? ? nil : ActiveSupport::JSON.encode(value))
          instance_variable_set field_ivar(field), value
        end
      end

      define_method :serialize_json_values do
        fields_with_defaults.keys.each do |field|
          if instance_variable_defined?(field_ivar(field)) then
            send :"#{field}=", instance_variable_get(field_ivar(field))
          end
        end
      end

      define_method :reload_with_refresh_json_ivars do |*args|
        res = reload_without_refresh_json_ivars *args
        fields_with_defaults.keys.each { |field| remove_instance_variable field_ivar(field) if instance_variable_defined?(field_ivar(field)) }
        res
      end

      define_method :update_with_refresh_json_ivars do |*args|
        res = update_without_refresh_json_ivars(*args)
        fields_with_defaults.keys.each { |field| remove_instance_variable field_ivar(field) if instance_variable_defined?(field_ivar(field)) }
        res
      end

      before_validation :serialize_json_values
      alias_method_chain :reload, :refresh_json_ivars
      alias_method_chain :update, :refresh_json_ivars
    end
  end

  private

  def field_ivar(name)
    :"@_deserialized_#{name}"
  end
end
