module EngineOfWar::TemplateEngines
  class Textile < Tilt::RedClothTemplate
    Tilt.register self, "textile"
    include EngineOfWar::TemplateEngines::Filters

    def prepare
      @engine = RedCloth.new(image_filter(code_filter(data)))
      @output = nil
    end
  end
end
