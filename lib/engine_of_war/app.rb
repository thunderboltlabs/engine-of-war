class EngineOfWar::App < Sinatra::Base
  register Padrino::Rendering
  register Padrino::Helpers

  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views/css'
  end

  disable :show_exceptions
  set :haml,        format: :html5
  set :scss,        Compass.sass_engine_options
  set :github_info, nil

  set :data_root do
    File.expand_path(root + '/data/')
  end

  def self.google_analytics_key=(key)
    use Rack::GoogleAnalytics, tracker: key
  end

  def self.gauges_key=(key)
    use Rack::Gauges, tracker: key
  end

  def self.site_title=(title)
    @site_title = title
    @site_title << " (#{ENV["RACK_ENV"]})" unless ENV["RACK_ENV"] == "production"
  end

  def self.site_title
    @site_title
  end

  def self.newrelic_key=(key)
    load_newrelic(key, name) unless ENV["RACK_ENV"] == "development" or ENV["RACK_ENV"].nil?
  end

  def load_newrelic(key, name)
    puts "Loading NewRelic for #{name}"
    require 'newrelic_rpm'
    require 'rpm_contrib'
    NewRelic::Agent.manual_start(monitor_mode: true, 
                                 license_key: key,
                                 app_name: name,
                                 monitor_mode: true,
                                 log_level: "info",
                                 log_file_path: "STDOUT",
                                 transaction_tracer: { enabled: false },
                                 error_collector: { enabled: true })
  end

  def render_page_with_layout(page)
    render_page(page, 
                layout: "layouts/#{page.layout}", 
                layout_engine: :haml)
  end

  helpers do
    def render_page(page, opts = {})
      opts[:locals] ||= {}
      opts[:locals][:meta] = page.meta
      opts[:locals][:page] = page
      send(page.engine, page.source, opts)
    end
 
    def collection(dir)
      EngineOfWar::PageCollection.new(dir)
    end

    def data(file)
      DeepStruct.from_file(File.join(settings.data_root, file))
    end
  end

  error(500) { haml :"500" }
  error(404) { haml :"404" }

  get "/*.atom" do |collection|
    content_type :rss
    builder do |xml|
      xml.instruct! :xml, :version => '1.0'
      xml.rss :version => "2.0" do
        xml.channel do
          xml.title EngineOfWar::App.settings.site_title
          xml.link "http://#{request.host}"

          collection(collection).each do |page|
            xml.item do
              xml.title page.meta[:title]
              xml.link "http://#{request.host}#{page.url}"
              xml.description render_page(page)
              xml.pubDate page.meta[:date].rfc822
              xml.guid "http://#{request.host}#{page.url}"
            end
          end
        end
      end
    end
  end

  get %r{^/([^.]+)$} do |name|
    render_page_with_layout(EngineOfWar::Page.new(name))
  end

  get "/" do
    render_page_with_layout(EngineOfWar::Page.new(:index))
  end

  get "/*.*" do |name, ext|
    content_type ext
    render :"#{name}", :layout => false
  end
end
