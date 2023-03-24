class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    Alphavantage.configure do |config|
      config.api_key = Rails.application.credentials.alphavantage[:api_key]
    end

    quote = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
    company = Alphavantage::Fundamental.new(symbol: ticker_symbol)
    begin
      if company.overview.name.nil?
        raise StandardError.new "Could not find the company overview"
      else
        new(ticker: ticker_symbol, name: company.overview.name, last_price: company.overview.analyst_target_price)
      end 
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
