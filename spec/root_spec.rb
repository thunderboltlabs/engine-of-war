require "spec_helper"

describe "given a layout" do
  before do
    create_template("layouts/application.html.haml", <<-EOP)
                    %html
                      %head
                      %body
                        %h1 Layout
                        = yield
                    EOP

  end

  describe "and a haml template named index.html.haml" do
    before { create_template("index.html.haml", "%h1 Haml") }

    context "on GET to /" do
      before { visit "/" }

      it "renders the template" do
        page.should have_selector('h1:contains("Haml")')
      end
      
      it "renders the layout" do
        page.should have_selector('h1:contains("Layout")')
      end
    end

    context "with google analytics configured" do
      before { Capybara.app.google_analytics_key = "UA-xxxxxx-x" }

      context "on GET to /" do
        before { visit "/" }

        it "renders the google analytics JS" do
          page.should have_selector('script[type="text/javascript"]:contains("google-analytics.com")')
          page.should have_selector('script[type="text/javascript"]:contains("UA-xxxxxx-x")')
        end
      end
    end

    context "with gauges configured" do
      before { Capybara.app.gauges_key = "gauges_key" }

      context "on GET to /" do
        before { visit "/" }

        it "renders the google analytics JS" do
          page.should have_selector('script[type="text/javascript"]:contains("gaug.es")')
          page.should have_selector('script[type="text/javascript"]:contains("gauges_key")')
        end
      end
    end
  end
end


