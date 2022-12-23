# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bamboo.Repo.insert!(%Bamboo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Bamboo.Stocks

defmodule BambooSeed do
  def multiply_seeder() do
    create_category()
  end

  def create_category() do
    categories = [
      %{
        name: "blockchain",
      },
      %{
        name: "earnings",
      },
      %{
        name: "ipo",
      },
      %{
        name: "mergers_and_acquisitions",
      },
      %{
        name: "financial_markets",
      },
      %{
        name: "economy_fiscal",
      },
      %{
        name: "economy_monetary",
      },
      %{
        name: "economy_macro",
      },
      %{
        name: "energy_transportation",
      },
      %{
        name: "finance",
      },
      %{
        name: "life_sciences",
      },
      %{
        name: "manufacturing",
      },
      %{
        name: "real_estate",
      },
      %{
        name: "retail_wholesale",
      },
      %{
        name: "technology",
      },
    ]
    Enum.each(categories, fn category ->
      Stocks.create_category(category)
    end)
  end
end

BambooSeed.multiply_seeder()
