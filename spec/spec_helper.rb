require "bundler/setup"
require 'rspec'
require 'capybara/rspec'
require 'fakeweb'

require "engine_of_war.rb"

Capybara.app = EngineOfWar::App
Capybara.app.set :root,  "/tmp/engine-#{$$}"
FakeWeb.allow_net_connect = false

def create_template(path, content)
  create_file "#{Capybara.app.settings.views}/#{path}", content.unindent
end

def create_asset(path, content)
  create_file "#{Capybara.app.settings.public_folder}/#{path}", content.unindent
end

def create_config(path, content)
  create_file "#{Capybara.app.settings.config}/#{path}", content.unindent
end

def create_file(path, content)
  FileUtils.mkdir_p(File.dirname(path))
  File.open(path, "w+") do |f|
    f << content
  end
end

def show_files
  pp Dir[File.join(File.dirname(Capybara.app.settings.views), "**", "*")]
end

def create_dirs
  FileUtils.mkdir_p(Capybara.app.settings.views)
  FileUtils.mkdir_p(Capybara.app.settings.public_folder)
  FileUtils.mkdir_p(Capybara.app.settings.config)
end

def remove_dirs
  FileUtils.rm_rf(Capybara.app.settings.views)
  FileUtils.rm_rf(Capybara.app.settings.public_folder)
  FileUtils.rm_rf(Capybara.app.settings.config)
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:all) do
    create_dirs
  end

  config.after(:all) do
    remove_dirs
  end

  config.before(:each) do
    remove_dirs
    create_dirs
  end
end

