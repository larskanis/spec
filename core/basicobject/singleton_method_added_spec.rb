require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/singleton_method', __FILE__)

describe "BasicObject#singleton_method_added" do
  before :each do
    ScratchPad.clear
  end

  it "is a private method" do
    BasicObject.should have_private_instance_method(:singleton_method_added)
  end

  it "is called when a method is defined on self" do
    class BasicObjectSpecs::SingletonMethod
      def self.new_method_on_self
      end
    end
    ScratchPad.recorded.should == [:method_added, :new_method_on_self]
  end

  it "is called when a method is defined in the singleton class" do
    class BasicObjectSpecs::SingletonMethod
      class << self
        def new_method_on_singleton
        end
      end
    end
    ScratchPad.recorded.should == [:method_added, :new_method_on_singleton]
  end

  it "is called when a method is defined with alias_method in the singleton class" do
    class BasicObjectSpecs::SingletonMethod
      class << self
        alias_method :new_method_on_singleton_with_alias_method, :singleton_method_to_alias
      end
    end
    ScratchPad.recorded.should == [:method_added, :new_method_on_singleton_with_alias_method]
  end

  it "is called when a method is defined with syntax alias in the singleton class" do
    class BasicObjectSpecs::SingletonMethod
      class << self
        alias new_method_on_singleton_with_syntax_alias singleton_method_to_alias
      end
    end
    ScratchPad.recorded.should == [:method_added, :new_method_on_singleton_with_syntax_alias]
  end

  it "is called when define_method is used in the singleton class" do
    class BasicObjectSpecs::SingletonMethod
      class << self
        define_method :new_method_with_define_method do
        end
      end
    end
    ScratchPad.recorded.should == [:method_added, :new_method_with_define_method]
  end
end
