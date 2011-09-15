require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe JsonSerialize do
  describe "#json_serialize" do
    context "[getter]" do
      it "should JSON-decode the value" do
        require 'logger'
        object = Json.create!
        Json.update_all(data: '{"foo":"bar"}')
        object.reload.data.should eql('foo' => 'bar')
      end

      it "should return nil if the value is nil" do
        object = Json.create!
        Json.update_all(data: nil)
        object.reload.data.should be_nil
      end
      
      it "should return a default value if the value is nil and a default is set" do
        object = Json.create!
        Json.update_all(default: nil)
        object.reload.default.should eql($default)
        object.reload.default.object_id.should_not eql($default.object_id)
      end
      
      it "should call the proc if the default is a proc" do
        object = Json.create!
        Json.update_all(default_proc: nil)
        object.reload.default_proc.should eql({})
      end
    end

    context "[setter]" do
      it "should JSON-encode the value" do
        object = Json.create!(data: { foo: 'bar' })
        object.send(:read_attribute, :data).should eql({ foo: 'bar' }.to_json)
      end

      it "should leave nil as nil" do
        object = Json.create!(data: nil)
        object.send(:read_attribute, :data).should be_nil
      end
    end
    
    context "[database backing]" do
      it "should back the instance object with the database" do
        object = Json.create!(data: { foo: 'bar' })
        object.data[:foo2] = 'bar2'
        object.save!
        object.data.should eql('foo' => 'bar', 'foo2' => 'bar2')
      end
      
      it "should clear the in-memory reference on reload" do
        object = Json.create!(data: { foo: 'bar' })
        object.data[:foo2] = 'bar2'
        object.reload
        object.data.should eql('foo' => 'bar')
      end
    end
  end
end
