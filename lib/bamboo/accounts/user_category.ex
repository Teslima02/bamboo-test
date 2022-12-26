defmodule Bamboo.Accounts.UserCategory do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "user_category" do
    belongs_to :user, Bamboo.Accounts.User, primary_key: true
    belongs_to :category, Bamboo.Stocks.Category, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(user_category, attrs) do
    user_category
    |> cast(attrs, [:user_id, :category_id])
  end
end
