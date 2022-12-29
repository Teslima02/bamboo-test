defmodule BambooWeb.StockControllerTest do
  use BambooWeb.ConnCase

  import Bamboo.StocksFixtures

  def setup_category(_) do
    category = Bamboo.StocksFixtures.category_fixture()
    {:ok, category: category}
  end

  @create_attrs %{address: "some address", country: "some country", currency: "some currency", name: "some name", symbol: "some symbol"}
  @update_attrs %{address: "some updated address", country: "some updated country", currency: "some updated currency", name: "some updated name", symbol: "some updated symbol"}
  @invalid_attrs %{address: nil, country: nil, currency: nil, name: nil, symbol: nil}

  describe "index" do
    test "filter stock by all default", %{conn: conn} do
      conn = get(conn, Routes.stock_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stocks"
    end

    test "filter stock by all", %{conn: conn} do
      conn = get(conn, Routes.stock_path(conn, :index, filter_by: "all"))
      assert html_response(conn, 200) =~ "Listing Stocks"
    end

    test "filter stock by new", %{conn: conn} do
      conn = get(conn, Routes.stock_path(conn, :index, filter_by: "new"))
      assert html_response(conn, 200) =~ "Listing Stocks"
    end

    test "filter stock by old", %{conn: conn} do
      conn = get(conn, Routes.stock_path(conn, :index, filter_by: "old"))
      assert html_response(conn, 200) =~ "Listing Stocks"
    end
  end

  describe "new stock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stock_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stock"
    end
  end

  describe "create stock" do
    setup [:setup_category]

    test "redirects to show when data is valid", %{conn: conn, category: category} do
      conn = post(conn, Routes.stock_path(conn, :create), category: category, stock: (@create_attrs))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stock_path(conn, :show, id)

      conn = get(conn, Routes.stock_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stock"
    end

    # test "renders errors when data is invalid", %{conn: conn, category: category,} do
    #   conn = post(conn, Routes.stock_path(conn, :create), category: category, stock: @invalid_attrs)
    #   assert html_response(conn, 200) =~ "New Stock"
    # end
  end

  describe "edit stock" do
    setup [:create_stock]

    test "renders form for editing chosen stock", %{conn: conn, stock: stock} do
      conn = get(conn, Routes.stock_path(conn, :edit, stock))
      assert html_response(conn, 200) =~ "Edit Stock"
    end
  end

  describe "update stock" do
    setup [:create_stock]

    test "redirects when data is valid", %{conn: conn, stock: stock} do
      conn = put(conn, Routes.stock_path(conn, :update, stock), stock: @update_attrs)
      assert redirected_to(conn) == Routes.stock_path(conn, :show, stock)

      conn = get(conn, Routes.stock_path(conn, :show, stock))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, stock: stock} do
      conn = put(conn, Routes.stock_path(conn, :update, stock), stock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stock"
    end
  end

  describe "delete stock" do
    setup [:create_stock]

    test "deletes chosen stock", %{conn: conn, stock: stock} do
      conn = delete(conn, Routes.stock_path(conn, :delete, stock))
      assert redirected_to(conn) == Routes.stock_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.stock_path(conn, :show, stock))
      end
    end
  end

  defp create_stock(_) do
    stock = stock_fixture()
    %{stock: stock}
  end
end
