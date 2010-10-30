# Adds the {#json_serialize} method to @ActiveRecord@ objects.
#
# @example Basic usage
#   class MyModel < ActiveRecord::Base
#     extend JsonSerialize
#     json_serialize :some_field
#   end

module JsonSerialize

  # @overload json_serialize(field, ...)
  #   Marks one or more fields as JSON-serialized. These fields are stored in
  #   the database as JSON and encoded/decoded automatically upon read/write.
  #   @param [Symbol] field The database field to JSON-serialize.

  def json_serialize(*fields)
    fields.each do |field|
      define_method field do
        value = read_attribute(field)
        value.nil? ? nil : ActiveSupport::JSON.decode(value)
      end

      define_method :"#{field}=" do |value|
        write_attribute field, (value.nil? ? nil : ActiveSupport::JSON.encode(value))
      end
    end
  end
end
