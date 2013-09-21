# module Capybara::Poltergeist
  # class Browser
    # prepend CapybaraHelpers
  # end
# end

module FuriousTypist
  module CapybaraHelpers
    def click_coordinates(x, y)
      super(x, y)
      wait_for_pending_ajax_request
    end

    def click(page_id, id)
      super(page_id, id)
      wait_for_pending_ajax_request
    end

    private

    def wait_for_pending_ajax_request(timeout = Capybara.default_wait_time)
      if jquery_defined? && active_ajax_requests != 0
        page.document.synchronize(timeout) do
          unless active_ajax_requests == 0
            raise "Timeout occurred before all AJAX requests completed"
          end
        end
      end
    end

    def jquery_defined?
      page.evaluate_script("jQuery !== null && typeof(jQuery) !== 'undefined'")
    end

    def active_ajax_requests
      page.evaluate_script("jQuery.active")
    end
  end
end
