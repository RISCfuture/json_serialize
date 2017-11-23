require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

RSpec.describe JsonSerialize do
  describe "#json_serialize" do
    context "[getter]" do
      it "should JSON-decode the value" do
        require 'logger'
        object = Json.create!
        Json.update_all(data: '{"foo":"bar"}')
        expect(object.reload.data).to eql('foo' => 'bar')
      end

      it "should return nil if the value is nil" do
        object = Json.create!
        Json.update_all(data: nil)
        expect(object.reload.data).to be_nil
      end

      it "should return a default value if the value is nil and a default is set" do
        object = Json.create!
        Json.update_all(default: nil)
        expect(object.reload.default).to eql($default)
        expect(object.reload.default.object_id).not_to eql($default.object_id)
      end

      it "should call the proc if the default is a proc" do
        object = Json.create!
        Json.update_all(default_proc: nil)
        expect(object.reload.default_proc).to eql({})
      end
    end

    context "[setter]" do
      it "should JSON-encode the value" do
        object = Json.create!(data: { foo: 'bar' })
        expect(object.send(:read_attribute, :data)).to eql({ foo: 'bar' }.to_json)
      end

      it "should leave nil as nil" do
        object = Json.create!(data: nil)
        expect(object.send(:read_attribute, :data)).to be_nil
      end
    end

    context "[database backing]" do
      it "should back the instance object with the database" do
        object             = Json.create!(data: { foo: 'bar' })
        object.data[:foo2] = 'bar2'
        object.save!
        expect(object.data).to eql(:foo => 'bar', :foo2 => 'bar2')
      end

      it "should clear the in-memory reference on reload" do
        object             = Json.create!(data: { foo: 'bar' }, default: %w( baz ))
        object.data[:foo2] = 'bar2'
        object.default     = %w( baz2 )
        object.reload
        expect(object.data).to eql('foo' => 'bar')
        expect(object.default).to eql(%w( baz ))
      end
    end
  end
end
