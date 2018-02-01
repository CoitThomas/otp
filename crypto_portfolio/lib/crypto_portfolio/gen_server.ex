defmodule CryptoPortfolio.GenServer do
  use GenServer

  alias CryptoPortfolio.Coin

  # API

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def add_coin(pid, name) do
    GenServer.cast(pid, {:add, name})
  end

  def remove_coin(pid, name) do
    GenServer.cast(pid, {:remove, name})
  end

  def portfolio(pid) do
    GenServer.call(pid, :portfolio)
  end

  # Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:add, name}, state) do
    coin = Coin.lookup(name)
    new_state = Map.put(state, name, coin)
    {:noreply, new_state}
  end

  def handle_cast({:remove, name}, state) do
    new_state = Map.delete(state, name)
    {:noreply, new_state}
  end

  def handle_call(:portfolio, _from, state) do
    {:reply, state, state}
  end
end

