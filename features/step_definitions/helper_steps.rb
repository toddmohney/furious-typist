module StepHelpers
  def current_path
    URI.parse(current_url).path
  end
end
World(StepHelpers)
