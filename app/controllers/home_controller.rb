require 'open-uri'

class HomeController < ApplicationController
  def index
  	categories = Array.new
    apps = Array.new
  	doc = Nokogiri::HTML(open('https://data.cityofgainesville.org/'))
  	doc.css("#sidebar #categories a").each do |item|
  		category = Hash.new
  		category[:name] = item.at_css("span.label").text
  		category[:link] = item['href']
  		categories << category
  	end

    doc.css("#explorer-apps div").each do |item|
      app = Hash.new
      app[:name] = item.at('a h3').text
      app[:link] = item.at('a')['href']
      apps << app
    end

  	render json: {:categories=>categories,:apps=>apps}
  end
end
