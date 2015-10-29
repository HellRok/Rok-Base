require "rok_base/engine"

# Require all dependencies, watch out as this could break when you add a new gem
Gem.loaded_specs['rok_base'].dependencies.each do |d|
  require d.name
end

require "rok_base/liquid_filters"

module RokBase
end
