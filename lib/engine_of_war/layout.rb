class Layout
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def name
    potential_layouts.first + ".html"
  end

  def potential_layouts
    [layout_from_directory, layout_from_meta, default_layout].reject(&:blank?).compact.select do |f|
      File.exists?(File.join(page.views_root, "layouts", "#{f}.html.haml"))
    end
  end

  def layout_from_directory
    File.dirname(page.request_path).sub!(%r{^[/.]}, "")
  end

  def layout_from_meta
    page.meta[:layout]
  end

  def default_layout
    "application"
  end
end
