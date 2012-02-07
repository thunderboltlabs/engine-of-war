#!/bin/env rspec

require "spec_helper"

describe "Given a page that uses data" do
  before do
    create_data("people.json", '[{"name": "Bob"}, {"name": "Sue"}]')
     
    create_template("layouts/application.html.haml", 
                    <<-EOF)
                      %h1 Application Layout
                      = yield
                    EOF
     
    create_template("people.html.haml", 
                    <<-EOF)
                      - data("people.json").each do |person|
                        %h2= person.name
                      %h3= data("people.json").sample.name
                    EOF
  end

  context "GET /people" do
    before { visit "/people" }

    it "renders the first person" do
      page.should have_selector('h2:contains("Bob")')
    end

    it "renders the second person" do
      page.should have_selector('h2:contains("Sue")')
    end
  end
end
