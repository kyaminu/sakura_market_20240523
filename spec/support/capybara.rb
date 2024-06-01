Capybara.add_selector(:test_class) do
  css { "[data-test-class='#{_1}']" }
end
