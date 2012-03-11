require "spec_helper"

describe "normal tests" do
  describe "given a template with an error" do
    before { create_template("raise.html.haml", ".h1= raise RuntimeError") }

    it "raises an error" do
      p ENV["RACK_ENV"]
      lambda { visit "/raise" }.should raise_error(RuntimeError)
    end
  end
end

# describe "when not raising errors" do
#   before do
#     Capybara.app.disable :raise_errors
#     Capybara.app.disable :show_exceptions
#   end
# 
#   after do
#     Capybara.app.enable :raise_errors 
#     Capybara.app.enable :show_exceptions
#   end
# 
#   describe "given a /public/500.html page" do
#     before do
#       create_template("raise.html.haml", ".h1= raise RuntimeError")
#       create_template("500.haml", "Bam")
#     end
# 
#     it "renders the page when there's an error" do
#       visit "/raise"
#       page.should have_selector('body p:contains("Bam")')
#     end
#   end
# 
#   describe "given a /public/404.html page" do
#     before { create_template("404.haml", "wat") }
# 
#     it "renders the page when there's a not-found error" do
#       visit "/thispagetotallydoesntexist"
#       page.should have_selector('body p:contains("wat")')
#     end
#   end
# end
