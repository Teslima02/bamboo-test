defmodule BambooWeb.StockController do
  use BambooWeb, :controller

  alias Bamboo.Stocks
  alias Bamboo.Stocks.Stock

  @new_list_topic "new_listed_stocks"
  def index(conn, params) do
    stocks = Stocks.list_stocks(params)
    render(conn, "index.html", stocks: stocks)
  end

  def search_stock(conn, params) do
    stocks = Stocks.search_stock(params)
    render(conn, "index.html", stocks: stocks)
  end

  def get_listed_stocks(conn, _params) do
    get_new_listed_stocks()

    conn
    |> put_flash(:info, "Request successful.")

    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Stocks.change_stock(%Stock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category, "stock" => stock_params}) do
    case Stocks.create_stock(category, stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock created successfully.")
        |> redirect(to: Routes.stock_path(conn, :show, stock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock = Stocks.get_stock!(id)
    render(conn, "show.html", stock: stock)
  end

  def edit(conn, %{"id" => id}) do
    stock = Stocks.get_stock!(id)
    changeset = Stocks.change_stock(stock)
    render(conn, "edit.html", stock: stock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock" => stock_params}) do
    stock = Stocks.get_stock!(id)

    case Stocks.update_stock(stock, stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock updated successfully.")
        |> redirect(to: Routes.stock_path(conn, :show, stock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock: stock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock = Stocks.get_stock!(id)
    {:ok, _stock} = Stocks.delete_stock(stock)

    conn
    |> put_flash(:info, "Stock deleted successfully.")
    |> redirect(to: Routes.stock_path(conn, :index))
  end

  def unique_name, do: "user#{System.unique_integer()}"

  def get_new_listed_stocks() do
    range = 1..5

    listed_stocks =
      Enum.map(range, fn _ ->
        %{
          name: unique_name(),
          symbol: "TD",
          currency: "USD",
          country: "US",
          address: "New York",
          category: Enum.random(Stocks.list_categories())
        }
      end)

    Phoenix.PubSub.broadcast(Bamboo.PubSub, @new_list_topic, listed_stocks)
    listed_stocks
  end
end
