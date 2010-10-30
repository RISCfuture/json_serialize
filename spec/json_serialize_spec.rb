require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module SpecSupport
  class JsonSerializeTester
    extend JsonSerialize
    json_serialize :field
    def read_attribute(field) @value end
    def write_attribute(field, value) @value = value end
    def get() @value end
    def set(value) @value = value end
  end
end

describe JsonSerialize do
  before :each do
    @object = SpecSupport::JsonSerializeTester.new
  end

  describe "#json_serialize" do
    context "getter" do
      it "should JSON-decode the value" do
        @object.set(ActiveSupport::JSON.encode({ foo: 'bar' }))
        @object.field.should eql({ 'foo' => 'bar' })
      end

      it "should return nil if the value is nil" do
        @object.set nil
        @object.field.should be_nil
      end
    end

    context "setter" do
      it "should JSON-encode the value" do
        @object.field = { foo: 'bar' }
        @object.get.should eql({ foo: 'bar' }.to_json)
      end

      it "should leave nil as nil" do
        @object.field = nil
        @object.get.should be_nil
      end
    end
  end
end
