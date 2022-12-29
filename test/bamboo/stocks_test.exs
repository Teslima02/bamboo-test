defmodule Bamboo.StocksTest do
  use Bamboo.DataCase

  alias Bamboo.Stocks

  def setup_category(_) do
    category = Bamboo.StocksFixtures.category_fixture()
    {:ok, category: category}
  end

  describe "categories" do
    alias Bamboo.Stocks.Category

    import Bamboo.StocksFixtures

    @invalid_attrs %{name: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Stocks.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Stocks.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Category{} = category} = Stocks.create_category(valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stocks.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Category{} = category} = Stocks.update_category(category, update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Stocks.update_category(category, @invalid_attrs)
      assert category == Stocks.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Stocks.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Stocks.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Stocks.change_category(category)
    end
  end

  describe "stocks" do
    setup [:setup_category]
    alias Bamboo.Stocks.Stock

    import Bamboo.StocksFixtures

    @invalid_attrs %{address: nil, country: nil, currency: nil, name: nil, symbol: nil}

    test "filter socks by all and returns all stocks" do
      stock = stock_fixture()
      assert Stocks.list_stocks(%{"filter_by" => "all"}) == [stock]
    end

    test "filter socks by new and returns all stocks" do
      stock = stock_fixture()
      assert Stocks.list_stocks(%{"filter_by" => "new"}) == [stock]
    end

    test "filter socks by old and returns all stocks" do
      stock = stock_fixture()
      assert Stocks.list_stocks(%{"filter_by" => "old"}) == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Stocks.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock", %{category: category} do
      valid_attrs = %{address: "some address", country: "some country", currency: "some currency", name: "some name", symbol: "some symbol"}

      assert {:ok, %Stock{} = stock} = Stocks.create_stock(category, valid_attrs)
      assert stock.address == "some address"
      assert stock.country == "some country"
      assert stock.currency == "some currency"
      assert stock.name == "some name"
      assert stock.symbol == "some symbol"
    end

    # test "create_stock/1 with invalid data returns error changeset", %{category: category} do
    #   assert {:error, %Ecto.Changeset{}} = Stocks.create_stock(category, @invalid_attrs)
    # end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{address: "some updated address", country: "some updated country", currency: "some updated currency", name: "some updated name", symbol: "some updated symbol"}

      assert {:ok, %Stock{} = stock} = Stocks.update_stock(stock, update_attrs)
      assert stock.address == "some updated address"
      assert stock.country == "some updated country"
      assert stock.currency == "some updated currency"
      assert stock.name == "some updated name"
      assert stock.symbol == "some updated symbol"
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Stocks.update_stock(stock, @invalid_attrs)
      assert stock == Stocks.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Stocks.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Stocks.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Stocks.change_stock(stock)
    end
  end
end
