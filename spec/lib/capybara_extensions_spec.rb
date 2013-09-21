require 'spec_helper'
require 'furious_typist/capybara_helpers'

describe "CapybaraHelpers" do
  class TestClass
    attr_reader :x, :y

    prepend ::FuriousTypist::CapybaraHelpers

    def click_coordinates(x, y)
      @x = x
      @y = y
    end

    def click(page_id, id)
      @page_id = page_id
      @id = id
    end
  end

  describe "#click_coordinates" do
    let(:test_class) { TestClass.new }
    let(:page) { double(:page) }
    let(:document) { double(:document) }
    let(:jquery_detection_script) { "jQuery !== null && typeof(jQuery) !== 'undefined'" }
    let(:jquery_active_script) { "jQuery.active" }
    let(:jquery_defined) { false }

    before do
      test_class.stub(:page).and_return(page)
      page.stub(:evaluate_script).with(jquery_detection_script).and_return(jquery_defined)
      page.stub(:document).and_return(document)
    end

    it "calls the original method" do
      test_class.click_coordinates(1,2)

      expect(test_class.x).to eq(1)
      expect(test_class.y).to eq(2)
    end

    describe "synchronizing the page" do

      context "when jQuery is undefined" do
        let(:jquery_defined) { false }

        it "does not synchronize on the page" do
          document.should_not_receive(:synchronize)
          test_class.click_coordinates(1,2)
        end
      end

      context "when jQuery is defined" do
        let(:jquery_defined) { true }

        before do
          page.stub(:evaluate_script).with(jquery_active_script).and_return(active_ajax_requests)
        end

        context "without active AJAX requests" do
          let(:active_ajax_requests) { 0 }

          it "does not synchronize on the page" do
            document.should_not_receive(:synchronize)
            test_class.click_coordinates(1,2)
          end
        end

        context "with active AJAX requests" do
          let(:active_ajax_requests) { 1 }

          it "synchronizes on the page" do
            document.should_receive(:synchronize)
            test_class.click_coordinates(1,2)
          end
        end
      end
    end
  end
end
