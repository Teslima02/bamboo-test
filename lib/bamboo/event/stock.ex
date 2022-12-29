defmodule Bamboo.Event.Stock do
  alias BambooWeb.StockController
  alias Bamboo.Stocks

  use GenServer

  @new_list_topic "new_listed_stocks"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def new_stock_instance(server \\ __MODULE__) do
    GenServer.cast(server, :check_new_stock)
  end

  def get_all_stocks(server \\ __MODULE__) do
    GenServer.call(server, :get_new_stocks)
  end

  def init(_) do
    Phoenix.PubSub.subscribe(Bamboo.PubSub, @new_list_topic)

    schedule_stock_provider()
    {:ok, nil}
  end

  def handle_cast(:check_new_stock, state) do
    stocks = StockController.get_new_listed_stocks()
    {:noreply, %{state: state, stocks: stocks}}
  end

  def handle_call(:get_new_stocks, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_info(:check_provider, state) do
    # always check get new listed stock api to see
    # if there is new stocks listed from stock provider
    StockController.get_new_listed_stocks()

    # Schedule another call again to check at every time specified
    schedule_stock_provider()

    {:noreply, state}
  end

  def handle_info(msg, state) do

    new_stocks(msg)
    {:noreply, state}
  end

  defp schedule_stock_provider do
    Process.send_after(self(), :check_provider, :timer.hours(1))
    # Process.send_after(self(), :check_provider, :timer.minutes(1))
    # Process.send_after(self(), :check_provider, :timer.seconds(2))
  end

  defp new_stocks(msg) do
    Enum.each(msg, fn(stock) -> {
      Stocks.create_stock(stock.category, stock)
    } end)
  end
end
