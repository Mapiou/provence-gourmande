# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require 'active_support/all'

puts 'Scraping 750g recipes...'

i = 1

10.times do

  url = "https://www.750g.com/recettes_cuisine_provencale.htm?page=#{i}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  i += 1

  recipes_url = []
  html_doc.search('h2').each do |h2|
    if h2.search('a').attribute('href').present?
      recipes_url << "https://www.750g.com" + h2.search('a').attribute('href').to_s
    end
  end

  recipes = []

  recipes_url.each do |url|
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    recipe_details = {}
    recipe_details[:name] = html_doc.search('h1').first.text
    recipe_details[:description] = html_doc.search('div.summary > p').text
    photo = html_doc.search('div.c-diapo__image img').attribute('src')
    if photo.nil?
      recipe_details[:photo] = ""
    else
      recipe_details[:photo] = photo.value
    end

    recipes << recipe_details
  end

  recipes.each do |recipe|
    if Recipe.find_or_create_by(name: recipe[:name]) do |element|
        element.name = recipe[:name]
        element.description = recipe[:description]
        element.photo = recipe[:photo]
        element.save!
      end
    end
  end

end

puts 'Scraping 750g recipes finished!'

puts 'Scraping Internaute restaurants...'

i = 1

10.times do
  url = "https://www.linternaute.com/restaurant/guide/dept-bouches-du-rhone/cuisine-provencale/?page=#{i}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  i += 1

  restaurants_url = []


  html_doc.search('#jSearchResults li').each do |li|
    if li.search('div > div.grid_col.w25 > a').attribute('href').present?
      restaurants_url << "https://www.linternaute.com" + li.search('div > div.grid_col.w25 > a').attribute('href').to_s
    end
  end

  restaurants_name = []
  restaurants_address = []
  restaurants_phone = []
  restaurants_price = []
  restaurants_photos = []
  restaurants_description = []

  restaurants_url.each do |url|
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    restaurants_name << html_doc.search('h1').text

    street = html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section:nth-child(1) > div > div.grid_col.w45.bu_restaurant_resume > div > header > ul > li.icomoon-location > span:nth-child(1)').text
    zipcode = html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section:nth-child(1) > div > div.grid_col.w45.bu_restaurant_resume > div > header > ul > li.icomoon-location > span:nth-child(2)').text
    city = html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section:nth-child(1) > div > div.grid_col.w45.bu_restaurant_resume > div > header > ul > li.icomoon-location > a:nth-child(3) > span').text
    full_adress = "#{street} #{zipcode.strip} #{city.strip}"
    restaurants_address << full_adress

    restaurants_phone << html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section:nth-child(1) > div > div.grid_col.w45.bu_restaurant_resume > div > header > ul > li.icomoon-phone > a').text

    price = html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section:nth-child(1) > div > div.grid_col.w45.bu_restaurant_resume > div > ul > li:nth-child(3) > a > span').text
    restaurants_price << price

    photo = html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section:nth-child(1) > div > div.grid_col.grid_col--middle.w55.bu_restaurant_slider_ct > div > div.gallery > div.swiper-wrapper > div > img').attribute('src')
    if photo.nil?
     restaurants_photos << ""
    else
      restaurants_photos << photo.value
    end

    description = html_doc.search('#adsLayout > div.layout_ct > div > div > main > article > section.bu_restaurant_section.bu_restaurant_section--fixed > div:nth-child(1) > p').text
    restaurants_description << description
  end

  restaurants_total = restaurants_name.zip(restaurants_address, restaurants_phone, restaurants_price, restaurants_photos, restaurants_description)

  restaurants_total.each_with_index do |restaurant, index|
    if Restaurant.find_or_create_by(name: restaurants_name[index]) do |element|
        element.name = restaurant[0]
        element.address = restaurant[1]
        element.phone = restaurant[2]
        element.price = restaurant[3]
        element.photo = restaurant[4]
        element.description = restaurant[5]
        element.save!
      end
    end
  end
end

puts 'Scraping Internaute restaurants finished!'
