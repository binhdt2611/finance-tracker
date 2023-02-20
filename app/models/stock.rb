class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    FinnhubRuby.configure do |config|
      config.api_key['api_key'] = Rails.application.credentials.finhub_client[:api_key]
    end
    finnhub_client = FinnhubRuby::DefaultApi.new
    finnhub_client.symbol_search(ticker_symbol)
  end
end
