defmodule BambooWeb.StockChannelTest do
  use BambooWeb.ChannelCase
  import Bamboo.StocksFixtures

  setup do
    {:ok, _, socket} =
      BambooWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(BambooWeb.StockChannel, "stock:new_listed_stocks")

    %{socket: socket}
  end

  test "broadcasts new listed stocks", %{socket: socket} do
    stock = stock_fixture()
    broadcast_from!(socket, "finance", stock)
    assert_push "finance", ^stock
  end
end
