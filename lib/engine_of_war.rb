require 'sinatra'
require 'rack/google-analytics'
require 'rack/gauges'
require 'compass'
require "builder"
require 'haml'
require 'sass'
require "RedCloth"
require "coffee-script"
require 'padrino-core/application/rendering'
require 'padrino-helpers'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/object/blank'
require 'date'
require 'json'

module EngineOfWar; end

require 'engine_of_war/version'
require 'engine_of_war/extensions/string'
require 'engine_of_war/template_engines/filters'
require 'engine_of_war/template_engines/textile'
require 'engine_of_war/template_engines/markdown'
require 'engine_of_war/layout'
require 'engine_of_war/page'
require 'engine_of_war/page_collection'
require 'engine_of_war/app'

