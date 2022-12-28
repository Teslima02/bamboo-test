defmodule Bamboo.Stocks.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :address, :country, :currency, :name, :symbol]}
  schema "stocks" do
    field :address, :string
    field :country, :string
    field :currency, :string
    field :name, :string
    field :symbol, :string
    belongs_to :category, Bamboo.Stocks.Category

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:name, :symbol, :currency, :country, :address])
    |> validate_required([:name, :symbol, :currency, :country, :address])
  end
end
