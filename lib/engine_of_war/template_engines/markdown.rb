module EngineOfWar::TemplateEngines
  class Markdown < Tilt::RDiscountTemplate
    Tilt.register self, "markdown"

    include EngineOfWar::TemplateEngines::Filters

    def prepare
      @engine = RDiscount.new(image_filter(code_filter(data)))
      @output = nil
    end
  end
end
