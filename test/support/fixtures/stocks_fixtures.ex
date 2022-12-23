defmodule Bamboo.StocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bamboo.Stocks` context.
  """

  alias Bamboo.Stocks.Category

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Bamboo.Stocks.create_category()

    category
  end

  @doc """
  Generate a stock.
  """
  def stock_fixture(), do: stock_fixture(%{})

  def stock_fixture(%Category{} = category), do: stock_fixture(category, %{})

  def stock_fixture(attrs) do
    category = category_fixture()
    stock_fixture(category, attrs)
  end

  def stock_fixture(%Category{} = category, attrs) do
    attrs =
      Enum.into(attrs, %{
        address: "some address",
        country: "some country",
        currency: "some currency",
        name: "some name",
        symbol: "some symbol"
      })

    {:ok, stock} = Bamboo.Stocks.create_stock(category, attrs)

    Bamboo.Stocks.get_stock!(stock.id)
  end
end
