json_serialize
==============

 **JSON serialization in ActiveRecord**

|             |                                 |
|:------------|:--------------------------------|
| **Author**  | Tim Morgan                      |
| **Version** | 2.2.2 (May 15, 2013)            |
| **License** | Released under the MIT license. |

About
-----

`json_serialize` gives you the ability to JSON-encode data into ActiveRecord
model fields. JSON is a more compact but less robust serialization than YAML.
Only hashes, arrays, and primitives can be reliably encoded to database fields;
other types may not decode properly or at all.

Installation and Usage
----------------------

Firstly, add the gem to your Rails project's `Gemfile`:

```` ruby
gem 'json_serialize'
````

Then, include into your model the `JsonSerialize` module, and call the
`json_serialize` method to indicate which fields should be serialized:

```` ruby
class MyModel < ActiveRecord::Base
  include JsonSerialize
  json_serialize :favorites, :preferences
end
````

More information can be found at the {JsonSerialize::ClassMethods#json_serialize}
method documentation.
