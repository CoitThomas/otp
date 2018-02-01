defmodule CryptoPortfolio.Coin do
  defstruct(
    symbol: nil,
    name: nil,
    market_cap: 0.00,
    price_usd: 0.00,
    rank: nil
  )

  def lookup(coin_name) do
    raw_coin = 
      coin_name
      |> build_url()
      |> HTTPoison.get!()
      |> parse_response() 

    %CryptoPortfolio.Coin{
      symbol: raw_coin["symbol"],
      name: raw_coin["name"],
      market_cap: raw_coin["market_cap_usd"],
      price_usd: raw_coin["price_usd"],
      rank: raw_coin["rank"]
    }    
  end 

  def build_url(coin_name) do
    "https://api.coinmarketcap.com/v1/ticker/#{coin_name}/?convert=USD"
  end

  def parse_response(response) do
    [raw_coin] = Poison.decode!(response.body)
    raw_coin
  end
end
  
