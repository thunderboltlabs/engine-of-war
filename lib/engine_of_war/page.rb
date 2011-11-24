class EngineOfWar::Page
  YAML_REGEXP = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  attr_reader :request_path, :views_root, :meta, :source

  def initialize(request_path)
    @views_root    = EngineOfWar::App.settings.views
    @request_path  = normalize_path(request_path)
    @entire_source = File.read(template_path)
    @meta, @source = split_body
  end
  
  def layout
    Layout.new(self).name
  end

  def url
    request_path
  end

  def engine
    template_path.split(".").last.to_sym
  end

  def github_edit_url
    relative_template_path = template_path.sub(views_root, "views")
    "https://github.com/thunderboltlabs/thunderboltlabs/edit/master/#{relative_template_path}"
  end

  private

  def normalize_path(path)
    path = path.to_s
    path.sub!(%r{/$}, "")
    path.start_with?("/") ? path : "/#{path}"
  end

  def split_body
    data = {}
    body = @entire_source
    if @entire_source =~ YAML_REGEXP
      data = hash_from_yaml($1)
      body = @entire_source.split(YAML_REGEXP).last
    end

    [HashWithIndifferentAccess.new(data), body]
  end

  def hash_from_yaml(yaml)
    begin
      return YAML.load(yaml)
    rescue ArgumentError => e
      raise e, "#{e.message}:\n#{yaml.inspect}"
    end
  end

  def template_path 
    first_template_matching(request_path)
  end

  def first_template_matching(name)
    pattern    = File.join(views_root, "#{name}.html.*")
    candidates = Dir[pattern]
    raise Sinatra::NotFound, "Could find no files matching #{pattern}" if candidates.empty?
    candidates.first
  end
end

