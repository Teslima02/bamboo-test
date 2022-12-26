defmodule Bamboo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    many_to_many :category, Bamboo.Stocks.Category, join_through: Bamboo.Accounts.UserCategory, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  def subscribe_to_category(user, category) do
    user
    |> cast(%{}, [])
    |> put_assoc(:category, [category | user.category])
  end
end
