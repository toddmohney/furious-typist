def use_selenium
  Capybara.current_driver = :selenium
end

def use_poltergeist
  Capybara.current_driver = :poltergeist
end

Before('@javascript') do
  use_poltergeist
end

Before('@selenium') do
  use_selenium
end
