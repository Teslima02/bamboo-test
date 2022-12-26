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
alias Bamboo.Accounts

defmodule BambooSeed do
  def multiply_seeder() do
    create_category()
    create_user()
    user_subscribe_to_category()
  end

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def unique_name, do: "user#{System.unique_integer()}"

  def user_subscribe_to_category do
    categories = Stocks.list_categories()
    users = Accounts.list_users()

    Enum.each(1..30, fn _ ->
      category = Enum.random(categories)
      user = Enum.random(users)

      Accounts.subscribe_to_category(user, category)
    end)
  end

  def create_user do
    Enum.each(1..30, fn _ ->
      user = %{
        email: unique_user_email(),
        name: unique_name()
      }

      Accounts.create_user(user)
    end)
  end

  def create_category() do
    categories = [
      %{
        name: "blockchain"
      },
      %{
        name: "earnings"
      },
      %{
        name: "ipo"
      },
      %{
        name: "mergers_and_acquisitions"
      },
      %{
        name: "financial_markets"
      },
      %{
        name: "economy_fiscal"
      },
      %{
        name: "economy_monetary"
      },
      %{
        name: "economy_macro"
      },
      %{
        name: "energy_transportation"
      },
      %{
        name: "finance"
      },
      %{
        name: "life_sciences"
      },
      %{
        name: "manufacturing"
      },
      %{
        name: "real_estate"
      },
      %{
        name: "retail_wholesale"
      },
      %{
        name: "technology"
      }
    ]

    Enum.each(categories, fn category ->
      Stocks.create_category(category)
    end)
  end
end

BambooSeed.multiply_seeder()
