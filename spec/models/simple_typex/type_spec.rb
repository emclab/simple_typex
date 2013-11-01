require 'spec_helper'

module SimpleTypex
  describe Type do
    it "should be OK" do
      c = FactoryGirl.build(:simple_typex_type)
      c.should be_valid
    end
    
    it "should reject nil name" do
      c = FactoryGirl.build(:simple_typex_type, :name => nil)
      c.should_not be_valid
    end

    it "should reject duplicate name " do
      c1 = FactoryGirl.create(:simple_typex_type)
      c2 = FactoryGirl.build(:simple_typex_type)
      c2.should_not be_valid
    end
  end
end
