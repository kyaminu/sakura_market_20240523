Capybara.add_selector(:test_class) do
  css { "[data-test-class='#{_1}']" }
end

RSpec.configure do |config|
  config.around(:each, type: :system) do |example|
    if example.metadata[:rack_test]
      driven_by :rack_test
    else
      browser = ENV['NO_HEADLESS'].present? ? :chrome : :headless_chrome
      driven_by :selenium, using: browser do |driver_option|
        # SEE: https://github.com/SeleniumHQ/selenium/issues/13112
        driver_option.add_argument('--headless=new') if browser == :headless_chrome
      end
    end

    example.run
  end
end
