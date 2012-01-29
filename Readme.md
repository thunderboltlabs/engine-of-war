== Engine of War

Static(ish) site engine extracted from "thunderboltlabs.com":http://thunderboltlabs.com and "tammersaleh.com":http://tammersaleh.com.

=== Installation

``` ruby
# Gemfile
gem 'engine_of_war'
```

``` ruby
# config.ru 
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'engine_of_war'

YAML::ENGINE.yamler = 'syck' # Heroku doesn't support 'psych'

EngineOfWar::App.root                 = File.dirname(__FILE__)
EngineOfWar::App.github_info          = "thunderboltlabs/thunderboltlabs"
EngineOfWar::App.site_title           = "Thunderbolt Labs"
EngineOfWar::App.google_analytics_key = "UA-xxxxxxxx-1"
EngineOfWar::App.gauges_key           = "xxxxxxxxxxxxxxxxxxxxxxxx"
EngineOfWar::App.newrelic_key         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

run EngineOfWar::App
```

=== Layout

