require 'JSON'
require 'CSV'

module SanDiegoBreweriesScraper
  def self.brewers_guild
    breweries = JSON.parse(File.read('support/sd_brewers_guild.json'))
    breweries_list = breweries.map do |brewery|
      type = /_brewery_/ =~ brewery[7] ? 'Brewery' : 'Pub'
      # [name, phone number, url, address, type]
      [brewery[0], brewery[2], brewery[4], brewery[8], type]
    end
    csv_string = CSV.generate do |csv|
      breweries_list.each { |brewery| csv << brewery }
    end
    File.write('san_diego_breweries.csv', csv_string)
  end
end

SanDiegoBreweriesScraper.brewers_guild
