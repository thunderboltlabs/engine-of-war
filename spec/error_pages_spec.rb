require "spec_helper"

describe "when not raising errors" do
  before { Capybara.app.disable :raise_errors }
  after  { Capybara.app.enable :raise_errors }

  describe "given a /public/500.html page" do
    before { create_template("500.haml", "Bam") }

    it "renders the page when there's an error" do
      visit "/raise_exception_for_testing"
      page.should have_selector('body p:contains("Bam")')
    end
  end

  describe "given a /public/404.html page" do
    before { create_template("404.haml", "wat") }

    it "renders the page when there's a not-found error" do
      visit "/thispagetotallydoesntexist"
      page.should have_selector('body p:contains("wat")')
    end
  end
end
