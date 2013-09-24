require 'spec_helper'

describe User::Naming do
  class TestClass
    include ActiveModel::Validations
    attr_accessor :first_name, :last_name
    include User::Naming
  end

  let(:test_class) { TestClass.new }

  describe "validations" do
    subject { test_class }

    it { should ensure_length_of(:first_name).is_at_most(64) }
    it { should ensure_length_of(:last_name).is_at_most(64) }

    context "when first and last name are blank" do
      it { should_not validate_presence_of(:first_name) }
      it { should_not validate_presence_of(:last_name) }
    end

    context "when first name is not blank" do
      before do
        test_class.first_name = "Sasquatch"
      end

      it { should validate_presence_of(:last_name) }
    end

    context "when last name is not blank" do
      before do
        test_class.last_name = "Cuomo"
      end

      it { should validate_presence_of(:first_name) }
    end
  end

  describe "#full_name" do
    let(:test_class) { TestClass.new }

    before do
      test_class.first_name = "john"
      test_class.last_name = "stamos"
    end

    subject { test_class.full_name }
    it { should == "john stamos" }
  end
end
