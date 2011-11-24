class EngineOfWar::App < Sinatra::Base
  register Padrino::Rendering
  register Padrino::Helpers
  
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'views/css'
  end

  set :haml,   { :format => :html5 }
  set :scss,   Compass.sass_engine_options
  set(:config) { File.expand_path(root + '/config/') }

  def render_page_with_layout(page)
    render_page(page, :layout => "layouts/#{page.layout}", :layout_engine => :haml)
  end

  get "/posts.atom" do
    content_type :rss
    builder do |xml|
      xml.instruct! :xml, :version => '1.0'
      xml.rss :version => "2.0" do
        xml.channel do
          xml.title "Thunderbolt Labs"
          xml.link "http://#{request.host}"

          collection("posts").each do |post|
            xml.item do
              xml.title post.meta[:title]
              xml.link "http://#{request.host}#{post.url}"
              xml.description render_page(post)
              xml.pubDate post.meta[:date].rfc822
              xml.guid "http://#{request.host}#{post.url}"
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
  end
end
